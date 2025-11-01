<%@page contentType="text/html" pageEncoding="UTF-8" %>

    <!-- Nút mở chatbot -->
    <button id="chat-btn" class="btn btn-primary rounded-circle">
        <i class="bi bi-chat-left-quote-fill"></i>
    </button>

    <!-- Khung chatbot -->
    <div id="chat-popup" class="flex-column">
        <div id="chat-header">
            Chatbot LaptopShop
            <button id="close-chat" class="btn btn-sm btn-light float-end">×</button>
        </div>
        <div id="chat-messages"></div>
        <div id="chat-input">
            <input type="text" id="message" class="form-control" placeholder="Nhập tin nhắn...">
            <button id="send-btn" class="btn btn-primary">Gửi</button>
        </div>
    </div>

    <!-- CSS riêng -->
    <style>
        #chat-btn {
            position: fixed;
            bottom: 90px;
            right: 32px;
            z-index: 999;
        }

        #chat-popup {
            display: none;
            position: fixed;
            bottom: 80px;
            right: 20px;
            width: 300px;
            max-height: 400px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background: #fff;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            z-index: 1000;
            flex-direction: column;
        }

        #chat-header {
            background: #0d6efd;
            color: white;
            padding: 10px;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            font-weight: bold;
        }

        #chat-messages {
            padding: 10px;
            height: 250px;
            overflow-y: auto;
            border-bottom: 1px solid #ccc;
        }

        .message {
            margin-bottom: 10px;
        }

        .message.user {
            text-align: right;
            color: #0d6efd;
        }

        .message.bot {
            text-align: left;
            color: #333;
        }

        #chat-input {
            display: flex;
            padding: 10px;
        }

        #chat-input input {
            flex: 1;
            margin-right: 5px;
        }
    </style>