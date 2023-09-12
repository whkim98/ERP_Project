<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERP LAB CHAT</title>
<style>
    body, html {
        width: 100%; height: 100%;
        min-width: 380px;
        min-height: 480px;
        padding: 0%; margin: 0%;
        display: flex;
        flex-direction: column;
    }

    #erpChatroom-container {
        display: flex;
        width: 100%; height: 100%;
        flex-direction: column;
        padding: 0%; margin: 0%;
    }

    #erpChatroomHead {
        background-color: greenyellow;
        padding: 0; margin: 0;
    }
    
    #erpChatroomMain {
        background-color: rgb(208, 255, 113);
        padding: 0; margin: 0;
        flex-grow: 1;
        overflow: auto;
    }
    
    #erpChatroomBottom {
        background-color: white;
        padding: 0; margin: 0;
    }

    #msgInput {
        width: 100%;
        height: 100px;
        resize: none;
        background-color: transparent;
        border: none; outline: none;
        overflow-y: auto;
    }

    #msgSend {
        background-color: rgb(208, 255, 113);
        border: 1px solid rgb(208, 255, 113);
        color: dimgray;
        cursor: pointer;
        border-radius: 3px;
        width: 55px; height: 35px;
        float: right;
    }

    #msgSend:hover {
        background-color: limegreen;
        border: 1px solid limegreen;
    }
</style>

</head>
<body>

<div id="erpChatroom-container">

    <div id="erpChatroomHead">
    
        <h2>채팅방 명</h2>
        참여인원 / 채팅방 검색 / 대화상대 초대 / ... 

    </div>
    
    <div id="erpChatroomMain">
        
        <table id="erpChatroomText">
            <tr>
                <th>보내는사람: </th>
                <td>Lorem ipsum dolor sit amet consectetur adipisicing elit. Aliquid unde incidunt illo aspernatur ipsa, rem, molestias enim sit inventore at amet consequatur tenetur eum? Nemo repellat consequuntur saepe facere. Porro.</td>
            </tr>
            <tr>
                <th>보내는사람: </th>
                <td>Lorem ipsum dolor sit amet consectetur adipisicing elit. Aliquid unde incidunt illo aspernatur ipsa, rem, molestias enim sit inventore at amet consequatur tenetur eum? Nemo repellat consequuntur saepe facere. Porro.</td>
            </tr>
            <tr>
                <th>보내는사람: </th>
                <td>Lorem ipsum dolor sit amet consectetur adipisicing elit. Aliquid unde incidunt illo aspernatur ipsa, rem, molestias enim sit inventore at amet consequatur tenetur eum? Nemo repellat consequuntur saepe facere. Porro.</td>
            </tr>
            <tr>
                <th>보내는사람: </th>
                <td>Lorem ipsum dolor sit amet consectetur adipisicing elit. Aliquid unde incidunt illo aspernatur ipsa, rem, molestias enim sit inventore at amet consequatur tenetur eum? Nemo repellat consequuntur saepe facere. Porro.</td>
            </tr>
            <tr>
                <th>보내는사람: </th>
                <td>Lorem ipsum dolor sit amet consectetur adipisicing elit. Aliquid unde incidunt illo aspernatur ipsa, rem, molestias enim sit inventore at amet consequatur tenetur eum? Nemo repellat consequuntur saepe facere. Porro.</td>
            </tr>
            
        </table>
    
    </div>
    
    <div id="erpChatroomBottom">
    
        <div>
            <textarea id="msgInput" placeholder="전송할 메세지를 입력하세요"></textarea>
        </div>
        
        <div>
            이모티콘/달력/파일/캡쳐/채팅창투명도설정/... 
            <input type="button" id="msgSend" value="전송">
        </div>
    
    </div>
	

</div>

<script type="text/javascript">



</script>

</body>
</html>