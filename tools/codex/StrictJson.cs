// AIOS strict JSON + deterministic serializer + the schema subset used by DOC-HANDOFF.
// No external packages, expressions, commands, references or callbacks.
using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using System.Text.RegularExpressions;

namespace AIOSHandoff {
  public sealed class StrictJson {
    private readonly string text;
    private int position, nodes;
    private StrictJson(string input) { text = input; }
    private static Exception Stop(string why) { return new FormatException("STOP: JSON " + why); }
    private void White() {
      while (position < text.Length && (text[position]==' ' || text[position]=='\t' || text[position]=='\r' || text[position]=='\n')) position++;
    }
    private void Need(char c) {
      if (position >= text.Length || text[position++] != c) throw Stop("syntax error.");
    }
    private string ReadString() {
      Need('"'); var result = new StringBuilder(); bool ended = false;
      while (position < text.Length) {
        char c = text[position++];
        if (c == '"') { ended = true; break; }
        if (c < 32) throw Stop("unescaped control character.");
        if (c == '\\') {
          if (position >= text.Length) throw Stop("incomplete escape.");
          char escape = text[position++];
          switch (escape) {
            case '"': c='"'; break; case '\\': c='\\'; break; case '/': c='/'; break;
            case 'b': c='\b'; break; case 'f': c='\f'; break;
            case 'n': c='\n'; break; case 'r': c='\r'; break; case 't': c='\t'; break;
            case 'u':
              if (position+4 > text.Length) throw Stop("incomplete Unicode escape.");
              int code;
              if (!Int32.TryParse(text.Substring(position,4), NumberStyles.AllowHexSpecifier, CultureInfo.InvariantCulture, out code))
                throw Stop("invalid Unicode escape.");
              position+=4; c=(char)code; break;
            default: throw Stop("unsupported escape.");
          }
        }
        result.Append(c);
        if (result.Length > 65536) throw Stop("string size limit.");
      }
      if (!ended) throw Stop("unterminated string.");
      string value=result.ToString();
      for (int i=0;i<value.Length;i++) {
        if (Char.IsHighSurrogate(value[i])) {
          if (i+1>=value.Length || !Char.IsLowSurrogate(value[++i])) throw Stop("unpaired Unicode surrogate.");
        } else if (Char.IsLowSurrogate(value[i])) throw Stop("unpaired Unicode surrogate.");
      }
      return value;
    }
    private object Value(int depth) {
      if (depth>20 || ++nodes>12000) throw Stop("depth/node limit.");
      White(); if (position>=text.Length) throw Stop("missing value.");
      char c=text[position];
      if (c=='{') {
        position++; White(); var map=new Dictionary<string,object>(StringComparer.Ordinal);
        if (position<text.Length && text[position]=='}') {position++; return map;}
        while (true) {
          if (position>=text.Length || text[position]!='"') throw Stop("object key required.");
          string key=ReadString(); if (key.Length>256) throw Stop("key size limit.");
          if (map.ContainsKey(key)) throw Stop("duplicate key.");
          White(); Need(':'); map.Add(key,Value(depth+1)); White();
          if (position<text.Length && text[position]=='}') {position++;return map;}
          Need(',');White();
        }
      }
      if (c=='[') {
        position++;White();var list=new List<object>();
        if (position<text.Length && text[position]==']') {position++;return list.ToArray();}
        while (true) {
          list.Add(Value(depth+1));White();
          if (position<text.Length && text[position]==']') {position++;return list.ToArray();}
          Need(',');White();
        }
      }
      if (c=='"') return ReadString();
      foreach (string literal in new string[]{"true","false","null"}) {
        if (position+literal.Length<=text.Length && text.Substring(position,literal.Length)==literal) {
          position+=literal.Length;
          if (literal=="null")return null;return literal=="true";
        }
      }
      int start=position;
      if (c=='-') position++;
      if (position>=text.Length || text[position]<'0' || text[position]>'9') throw Stop("invalid value.");
      if (text[position]=='0')position++;
      else while (position<text.Length && text[position]>='0' && text[position]<='9')position++;
      if (position<text.Length && (text[position]=='.' || text[position]=='e' || text[position]=='E')) throw Stop("only integer numbers are supported.");
      long number;
      if (!Int64.TryParse(text.Substring(start,position-start),NumberStyles.AllowLeadingSign,CultureInfo.InvariantCulture,out number)) throw Stop("integer overflow.");
      return number;
    }
    public static object Parse(string input) {
      if (input==null || input.Length>2097152)throw Stop("payload size limit.");
      var reader=new StrictJson(input);object value=reader.Value(0);reader.White();
      if (reader.position!=input.Length)throw Stop("trailing data.");return value;
    }
    private static void StringValue(StringBuilder output,string value) {
      output.Append('"');
      for(int i=0;i<value.Length;i++) {
        char c=value[i];
        switch(c) {
          case '"':output.Append("\\\"");break;case '\\':output.Append("\\\\");break;
          case '\b':output.Append("\\b");break;case '\f':output.Append("\\f");break;
          case '\n':output.Append("\\n");break;case '\r':output.Append("\\r");break;case '\t':output.Append("\\t");break;
          default:
            if(c<32)output.Append("\\u"+((int)c).ToString("x4",CultureInfo.InvariantCulture));
            else {
              if(Char.IsHighSurrogate(c)) {
                if(i+1>=value.Length || !Char.IsLowSurrogate(value[i+1]))throw Stop("unpaired Unicode surrogate.");
                output.Append(c);output.Append(value[++i]);
              } else {
                if(Char.IsLowSurrogate(c))throw Stop("unpaired Unicode surrogate.");output.Append(c);
              }
            }break;
        }
      }
      output.Append('"');
    }
    private static void Indent(StringBuilder output,int depth) {output.Append(' ',depth*2);}
    private static void Write(StringBuilder output,object value,int depth) {
      if(depth>20)throw Stop("serializer depth limit.");
      if(value==null){output.Append("null");return;}
      if(value is string){StringValue(output,(string)value);return;}
      if(value is bool){output.Append((bool)value?"true":"false");return;}
      if(value is Int32 || value is Int64){output.Append(Convert.ToInt64(value).ToString(CultureInfo.InvariantCulture));return;}
      var map=value as IDictionary;
      if(map!=null) {
        var keys=new List<string>();foreach(object key in map.Keys) {
          if(!(key is string))throw Stop("non-string key.");keys.Add((string)key);
        }
        keys.Sort(StringComparer.Ordinal);output.Append('{');
        for(int i=0;i<keys.Count;i++) {
          if(i>0)output.Append(',');output.Append('\n');Indent(output,depth+1);
          StringValue(output,keys[i]);output.Append(": ");Write(output,map[keys[i]],depth+1);
        }
        if(keys.Count>0){output.Append('\n');Indent(output,depth);}output.Append('}');return;
      }
      var array=value as object[];
      if(array!=null) {
        output.Append('[');
        for(int i=0;i<array.Length;i++) {
          if(i>0)output.Append(',');output.Append('\n');Indent(output,depth+1);Write(output,array[i],depth+1);
        }
        if(array.Length>0){output.Append('\n');Indent(output,depth);}output.Append(']');return;
      }
      throw Stop("unsupported serializer type.");
    }
    public static string Canonical(object value) {var output=new StringBuilder();Write(output,value,0);output.Append('\n');return output.ToString();}
    public static object ParseCanonical(byte[] bytes) {
      if(bytes==null || bytes.Length>2097152)throw Stop("payload size limit.");
      if(bytes.Length>=3 && bytes[0]==239 && bytes[1]==187 && bytes[2]==191)throw Stop("BOM excluded.");
      string input;
      try{input=new UTF8Encoding(false,true).GetString(bytes);}catch{throw Stop("invalid UTF-8.");}
      object value=Parse(input);
      if(!String.Equals(input,Canonical(value),StringComparison.Ordinal))throw Stop("non-canonical byte representation.");
      return value;
    }
    private static readonly HashSet<string> Keywords = new HashSet<string>(new string[]{
      "$schema","$id","$comment","type","additionalProperties","properties","required","oneOf","items","minItems","maxItems","uniqueItems",
      "pattern","minimum","maximum","minLength","maxLength","const","enum"},StringComparer.Ordinal);
    private static long Integer(object value) {if(!(value is Int32 || value is Int64))throw Stop("schema integer required.");return Convert.ToInt64(value);}
    private static bool Equal(object a,object b){return Canonical(a)==Canonical(b);}
    public static void Validate(object value,object schema){ValidateAt(value,schema,"$");}
    private static void ValidateAt(object value,object schema,string path) {
      var rule=schema as IDictionary;if(rule==null)throw Stop("schema object required.");
      foreach(object key in rule.Keys)if(!Keywords.Contains((string)key))throw Stop("unsupported schema keyword.");
      if(rule.Contains("oneOf")) {
        if(rule.Count!=1)throw Stop("oneOf schema siblings are unsupported.");
        int matches=0;foreach(object branch in (object[])rule["oneOf"]) {
          try{ValidateAt(value,branch,path);matches++;}catch(FormatException){}
        }
        if(matches!=1)throw Stop("oneOf mismatch at "+path);return;
      }
      if(rule.Contains("const") && !Equal(value,rule["const"]))throw Stop("constant mismatch at "+path);
      if(rule.Contains("enum")) {
        bool found=false;foreach(object allowed in (object[])rule["enum"])if(Equal(value,allowed))found=true;
        if(!found)throw Stop("enum mismatch at "+path);
      }
      if(!rule.Contains("type"))return;
      string type=(string)rule["type"];
      if(type=="object") {
        var map=value as IDictionary;if(map==null)throw Stop("object type mismatch at "+path);
        var properties=rule["properties"] as IDictionary;
        if(properties==null || !rule.Contains("additionalProperties") || !Equal(rule["additionalProperties"],false))throw Stop("closed object schema required.");
        foreach(object key in map.Keys)if(!properties.Contains(key))throw Stop("unknown field at "+path);
        foreach(object key in (object[])rule["required"])if(!map.Contains(key))throw Stop("missing field at "+path);
        foreach(object key in map.Keys)ValidateAt(map[key],properties[key],path+"."+(string)key);
      } else if(type=="array") {
        var array=value as object[];if(array==null)throw Stop("array type mismatch at "+path);
        if(rule.Contains("minItems") && array.Length<Integer(rule["minItems"]))throw Stop("array too short at "+path);
        if(rule.Contains("maxItems") && array.Length>Integer(rule["maxItems"]))throw Stop("array too long at "+path);
        var seen=new HashSet<string>(StringComparer.Ordinal);
        for(int i=0;i<array.Length;i++) {
          if(rule.Contains("uniqueItems") && Equal(rule["uniqueItems"],true) && !seen.Add(Canonical(array[i])))throw Stop("duplicate array item at "+path);
          ValidateAt(array[i],rule["items"],path+"["+i+"]");
        }
      } else if(type=="string") {
        string s=value as string;if(s==null)throw Stop("string type mismatch at "+path);
        // JSON Schema length counts Unicode code points, not UTF-16 units.
        int length=0;for(int i=0;i<s.Length;i++){length++;if(Char.IsHighSurrogate(s[i]))i++;}
        if(rule.Contains("minLength") && length<Integer(rule["minLength"]))throw Stop("string too short at "+path);
        if(rule.Contains("maxLength") && length>Integer(rule["maxLength"]))throw Stop("string too long at "+path);
        if(rule.Contains("pattern")) {
          var regex=new Regex((string)rule["pattern"],RegexOptions.CultureInvariant,TimeSpan.FromMilliseconds(100));
          Match match=regex.Match(s);
          // All patterns in this pinned schema describe a complete scalar.
          // Check the consumed length too: .NET '$' can otherwise stop before final LF.
          if(!match.Success || match.Index!=0 || match.Length!=s.Length)throw Stop("pattern mismatch at "+path);
        }
      } else if(type=="integer") {
        long n=Integer(value);
        if(rule.Contains("minimum") && n<Integer(rule["minimum"]))throw Stop("integer below minimum at "+path);
        if(rule.Contains("maximum") && n>Integer(rule["maximum"]))throw Stop("integer above maximum at "+path);
      } else if(type=="boolean") {
        if(!(value is bool))throw Stop("boolean type mismatch at "+path);
      } else throw Stop("unsupported schema type.");
    }
  }
}
