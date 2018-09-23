import diet.internal.html : htmlEscape, htmlAttribEscape;
import std.format : formattedWrite;
_diet_output.put("<!DOCTYPE html>
<html>
	<head>
		<title>");
#line 4 "room.dt"
_diet_output.htmlEscape(id);
_diet_output.put(" - WebChat</title><style>textarea, input { width: 100%; }\ntextarea { resize: vertical; }</style>
	</head>
	<body>
		<h1>Room '");
#line 9 "room.dt"
_diet_output.htmlEscape(id);
_diet_output.put("'</h1>
		<textarea id=\"history\"");
#line 11 "room.dt"

				static if (is(typeof(() { return 20; }()) == bool) )
			{
#line 11 "room.dt"
if (20) _diet_output.put(" rows");
#line 11 "room.dt"
} else static if (is(typeof(20) : const(char)[])) {{
#line 11 "room.dt"
  auto val = 20;
#line 11 "room.dt"
  if (val !is null) {
_diet_output.put(" rows=\"");
#line 11 "room.dt"
    _diet_output.filterHTMLAttribEscape(val);
_diet_output.put("\"");
#line 11 "room.dt"
  }
#line 11 "room.dt"
}} else {
_diet_output.put(" rows=\"");
#line 11 "room.dt"
_diet_output.htmlAttribEscape(20);
_diet_output.put("\"");
#line 11 "room.dt"
}
_diet_output.put(" readonly>");
#line 12 "room.dt"
 foreach (ln; messages) {
_diet_output.put("
			");
#line 13 "room.dt"
_diet_output.htmlEscape(ln);
#line 12 "room.dt"
}
_diet_output.put("
		</textarea>
		<form action=\"room\" method=\"POST\" onsubmit=\"return sendMessage()\">
			<input type=\"hidden\" name=\"id\"");
#line 16 "room.dt"

				static if (is(typeof(() { return id; }()) == bool) )
			{
#line 16 "room.dt"
if (id) _diet_output.put(" value");
#line 16 "room.dt"
} else static if (is(typeof(id) : const(char)[])) {{
#line 16 "room.dt"
  auto val = id;
#line 16 "room.dt"
  if (val !is null) {
_diet_output.put(" value=\"");
#line 16 "room.dt"
    _diet_output.filterHTMLAttribEscape(val);
_diet_output.put("\"");
#line 16 "room.dt"
  }
#line 16 "room.dt"
}} else {
_diet_output.put(" value=\"");
#line 16 "room.dt"
_diet_output.htmlAttribEscape(id);
_diet_output.put("\"");
#line 16 "room.dt"
}
_diet_output.put("/>
			<input type=\"hidden\" name=\"name\"");
#line 17 "room.dt"

				static if (is(typeof(() { return name; }()) == bool) )
			{
#line 17 "room.dt"
if (name) _diet_output.put(" value");
#line 17 "room.dt"
} else static if (is(typeof(name) : const(char)[])) {{
#line 17 "room.dt"
  auto val = name;
#line 17 "room.dt"
  if (val !is null) {
_diet_output.put(" value=\"");
#line 17 "room.dt"
    _diet_output.filterHTMLAttribEscape(val);
_diet_output.put("\"");
#line 17 "room.dt"
  }
#line 17 "room.dt"
}} else {
_diet_output.put(" value=\"");
#line 17 "room.dt"
_diet_output.htmlAttribEscape(name);
_diet_output.put("\"");
#line 17 "room.dt"
}
_diet_output.put("/>
			<input id=\"inputLine\" type=\"text\" name=\"message\" autofocus/>
		</form>");
#line 20 "room.dt"
 import vibe.data.json; {
#line 20 "room.dt"
}
_diet_output.put("
		<script src=\"scripts/chat.js\"></script><script>connect(");
#line 22 "room.dt"
_diet_output.htmlEscape(Json(id));
_diet_output.put(", ");
#line 22 "room.dt"
_diet_output.htmlEscape(Json(name));
_diet_output.put(")</script>
	</body>
</html>");
