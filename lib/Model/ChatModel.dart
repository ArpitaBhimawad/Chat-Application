class ChatModel {
  String? id;
  String? message;
  String? senderName;
  String? senderId;
  String? receiverId;
  String? timestamp;
  String? readStatus;
  String? imageUrl;
  String? videoUrl;
  String? audioUrl;
  String? documentUrl;
  List<String>? reactions;
  List<dynamic>? replies;

  ChatModel({
    this.id,
    this.message,
    this.senderName,
    this.senderId,
    this.receiverId,
    this.timestamp,
    this.readStatus,
    this.imageUrl,
    this.videoUrl,
     this.audioUrl,
   this.documentUrl,
   this.reactions,
     this.replies,
  });

  // Convert from JSON
  factory  ChatModel.fromJson(Map<String, dynamic> json) {
    return  ChatModel(
      id: json['id'] ?? '',
      message: json['message'] ?? '',
      senderName: json['senderName'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      timestamp: json['timestamp'] ?? '',
      readStatus: json['readStatus'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      audioUrl: json['audioUrl'] ?? '',
      documentUrl: json['documentUrl'] ?? '',
      reactions: List<String>.from(json['reactions'] ?? []),
      replies: List<dynamic>.from(json['replies'] ?? []),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'senderName': senderName,
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': timestamp,
      'readStatus': readStatus,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'audioUrl': audioUrl,
      'documentUrl': documentUrl,
      'reactions': reactions,
      'replies': replies,
    };
  }
}
