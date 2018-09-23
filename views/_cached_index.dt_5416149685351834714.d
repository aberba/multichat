import diet.internal.html : htmlEscape, htmlAttribEscape;
import std.format : formattedWrite;
_diet_output.put("<!DOCTYPE html>
<html>
	<head>
		<title>Welcome to WebChat</title>
	</head>
	<body>
		<h1>Welcome to WebChat</h1><p>Please enter the name of a chat room to join a chat:</p>
		<form action=\"/room\" method=\"GET\">
			<p>
				<label for=\"id\">Chat room:</label>
				<input id=\"id\" type=\"text\" name=\"id\" autofocus/>
			</p>
			<p>
				<label for=\"name\">Your name:</label>
				<input id=\"name\" type=\"text\" name=\"name\"/>
			</p>
			<button type=\"submit\">Enter</button>
		</form>
	</body>
</html>");
