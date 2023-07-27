import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';

class Meeting extends StatefulWidget {
  final Function(int) goToPage;
  const Meeting({required this.goToPage, Key? key}) : super(key: key);

  @override
  _MeetingState createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "");
  final subjectText = TextEditingController(text: "");
  final tokenText = TextEditingController();
  final userDisplayNameText = TextEditingController(text: "");
  final userEmailText = TextEditingController(text: "");
  final userAvatarUrlText = TextEditingController();

  bool isAudioMuted = true;
  bool isAudioOnly = false;
  bool isVideoMuted = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 248, 242),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 255, 248, 242),
        foregroundColor: Color.fromARGB(255, 255, 248, 242),
        surfaceTintColor: Color.fromARGB(255, 255, 248, 242),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 210, 210, 210),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: IconButton(
                onPressed: () {
                  widget.goToPage(10);
                },
                icon: Icon(
                  size: 24,
                  CupertinoIcons.chevron_back,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              'Görüntülü Görüşme Ayarları',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 5.0,
                    color: Color.fromARGB(81, 0, 0, 0),
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
            Icon(
              CupertinoIcons.chevron_back,
              color: Colors.transparent,
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: buildMeetConfig(),
      ),
    );
  }

  Widget buildMeetConfig() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 16.0),
          _buildTextField(
            hintText: "Server URL",
            controller: serverText,
          ),
          const SizedBox(height: 16.0),
          _buildTextField(hintText: "Oda", controller: roomText),
          const SizedBox(height: 16.0),
          _buildTextField(hintText: "Konu", controller: subjectText),
          const SizedBox(height: 16.0),
          _buildTextField(hintText: "Token", controller: tokenText),
          const SizedBox(height: 16.0),
          _buildTextField(
            hintText: "Kullanıcı Adı",
            controller: userDisplayNameText,
          ),
          const SizedBox(height: 16.0),
          _buildTextField(
            hintText: "Email",
            controller: userEmailText,
          ),
          const SizedBox(height: 16.0),
          _buildTextField(
            hintText: "User Avatar URL",
            controller: userAvatarUrlText,
          ),
          const SizedBox(height: 16.0),
          CheckboxListTile(
            title: const Text("Ses Kapalı"),
            value: isAudioMuted,
            onChanged: _onAudioMutedChanged,
            checkColor: Colors.black,
            activeColor: Color.fromARGB(255, 255, 248, 242),
          ),
          const SizedBox(height: 16.0),
          CheckboxListTile(
            title: const Text("Yalnızca Ses ile"),
            value: isAudioOnly,
            onChanged: _onAudioOnlyChanged,
            checkColor: Colors.black,
            activeColor: Color.fromARGB(255, 255, 248, 242),
          ),
          const SizedBox(height: 16.0),
          CheckboxListTile(
            title: const Text("Görüntü Kapalı"),
            value: isVideoMuted,
            onChanged: _onVideoMutedChanged,
            checkColor: Colors.black,
            activeColor: Color.fromARGB(255, 255, 248, 242),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: ElevatedButton(
              onPressed: () => _joinMeeting(),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 50),
                backgroundColor: Color.fromARGB(255, 135, 69, 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text(
                'Toplantıya Katıl',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 48.0),
        ],
      ),
    );
  }

  _onAudioOnlyChanged(bool? value) {
    setState(() {
      isAudioOnly = value!;
    });
  }

  _onAudioMutedChanged(bool? value) {
    setState(() {
      isAudioMuted = value!;
    });
  }

  _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value!;
    });
  }

  _joinMeeting() async {
    String? serverUrl = serverText.text.trim().isEmpty ? null : serverText.text;

    Map<String, Object> featureFlags = {};

    // Define meetings options here
    var options = JitsiMeetingOptions(
      roomNameOrUrl: roomText.text,
      serverUrl: serverUrl,
      subject: subjectText.text,
      token: tokenText.text,
      isAudioMuted: isAudioMuted,
      isAudioOnly: isAudioOnly,
      isVideoMuted: isVideoMuted,
      userDisplayName: userDisplayNameText.text,
      userEmail: userEmailText.text,
      featureFlags: featureFlags,
    );

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeetWrapper.joinMeeting(
      options: options,
      listener: JitsiMeetingListener(
        onOpened: () => debugPrint("onOpened"),
        onConferenceWillJoin: (url) {
          debugPrint("onConferenceWillJoin: url: $url");
        },
        onConferenceJoined: (url) {
          debugPrint("onConferenceJoined: url: $url");
        },
        onConferenceTerminated: (url, error) {
          debugPrint("onConferenceTerminated: url: $url, error: $error");
        },
        onAudioMutedChanged: (isMuted) {
          debugPrint("onAudioMutedChanged: isMuted: $isMuted");
        },
        onVideoMutedChanged: (isMuted) {
          debugPrint("onVideoMutedChanged: isMuted: $isMuted");
        },
        onScreenShareToggled: (participantId, isSharing) {
          debugPrint(
            "onScreenShareToggled: participantId: $participantId, "
            "isSharing: $isSharing",
          );
        },
        onParticipantJoined: (email, name, role, participantId) {
          debugPrint(
            "onParticipantJoined: email: $email, name: $name, role: $role, "
            "participantId: $participantId",
          );
        },
        onParticipantLeft: (participantId) {
          debugPrint("onParticipantLeft: participantId: $participantId");
        },
        onParticipantsInfoRetrieved: (participantsInfo, requestId) {
          debugPrint(
            "onParticipantsInfoRetrieved: participantsInfo: $participantsInfo, "
            "requestId: $requestId",
          );
        },
        onChatMessageReceived: (senderId, message, isPrivate) {
          debugPrint(
            "onChatMessageReceived: senderId: $senderId, message: $message, "
            "isPrivate: $isPrivate",
          );
        },
        onChatToggled: (isOpen) => debugPrint("onChatToggled: isOpen: $isOpen"),
        onClosed: () => debugPrint("onClosed"),
      ),
    );
  }

  Widget _buildTextField({
    String? hintText,
    required TextEditingController controller,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          hintText: hintText,
          filled: true,
          fillColor: Color.fromARGB(180, 224, 137, 50),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide:
                BorderSide(color: const Color.fromARGB(255, 159, 105, 85)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide:
                BorderSide(color: const Color.fromARGB(255, 192, 130, 107)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: Color.fromARGB(255, 179, 107, 81)),
          ),
        ),
      ),
    );
  }
}
