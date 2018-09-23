
import vibe.d;

final class WebChat {
	private Room[string] m_rooms;

	// GET /
	void get()
	{
		render!"index.dt";
	}

	string translateTo(string fromLanguage, string toLanguage, string message)
	{
		//FIX: use Bing translate api
		return message;
	}

	void getRoom(string id, string name, string lang="en")
	{
		auto msgs = getOrCreateRoom(id).chats;

		import std.algorithm: map;

		auto chats = msgs.map!(m => {
			if (m.lang == lang)
			{
				return m.message;
			}
			else
			{
				return translateTo(m.lang, lang, m.message);
			}
		});

		render!("room.dt", id, name, lang, chats);
	}

	void postRoom(string id, string name, string message, string lang="en")
	{
		// Store messages in room
		if (message.length)
			getOrCreateRoom(id).addMessage(name, message, lang);

		redirect("room?id="~id.urlEncode~"&name="~name.urlEncode);
	}

	private Room getOrCreateRoom(string id)
	{
		if (auto pr = id in m_rooms) return *pr;
		return m_rooms[id] = new Room;
	}

	// GET /ws?room=...&name=...
	void getWS(string room, string name, string lang, scope WebSocket socket)
	{
		auto r = getOrCreateRoom(room);

		auto writer = runTask({
			auto next_message = r.chats.length;

			while (socket.connected) {
				while (next_message < r.chats.length)
					//string toLang = r.chats[next_message++].lang;
					//string msg = translateTo(lang, toLang, r.chats[next_message++].message);
					string msg = r.chats[next_message++].message;
					socket.send(msg);
				r.waitForMessage(next_message);
			}
		});

		while (socket.waitForData) {
			auto message = socket.receiveText();
			// FIX: extract language from message prefix
			if (message.length) r.addMessage(name, message, "en");
		}

		writer.join(); // wait for writer task to exit
	}
}

struct Message
{
	string name;
	string message;
	string lang;
}

final class Room {
	Message[] chats;
	ManualEvent messageEvent;

	this()
	{
		messageEvent = createManualEvent();
	}

	void addMessage(string name, string message, string lang="en")
	{
		chats ~= Message(name, message, lang);
		messageEvent.emit();
	}

	void waitForMessage(size_t next_message)
	{
		while (chats.length <= next_message)
			messageEvent.wait();
	}
}

shared static this()
{
	auto router = new URLRouter;
	// registers each method of WebChat in the router
	router.registerWebInterface(new WebChat);
	// match incoming requests to files in the public/ folder
	router.get("*", serveStaticFiles("public/"));


	auto settings = new HTTPServerSettings;
	settings.port = 8080;
	settings.bindAddresses = ["::1", "127.0.0.1"];
	listenHTTP(settings, router);

	logInfo("Please open http://127.0.0.1:8080/ in your browser.");
}

