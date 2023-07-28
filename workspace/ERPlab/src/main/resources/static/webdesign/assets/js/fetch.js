let currentOpenFetchContent = null;

    function toggleFetchContent(fetchContentId, url) {
        var fetchContent = document.getElementById(fetchContentId);

        // 현재 열려있는 FetchContent가 있으면 닫기
        if (currentOpenFetchContent === fetchContent) {
            fetchContent.innerHTML = '';
            currentOpenFetchContent = null;
            return;
        }

        // 모든 FetchContent 닫기
        closeAllFetchContents();

        // FetchContent를 열기
        fetch(url).then(function(response) {
            response.text().then(function(text) {
                fetchContent.innerHTML = text;
                currentOpenFetchContent = fetchContent;
            });
        });
    }

    // 모든 FetchContent를 닫는 함수 정의
    function closeAllFetchContents() {
        var fetchContents = document.getElementsByName("f");
        for (var i = 0; i < fetchContents.length; i++) {
            fetchContents[i].innerHTML = '';
        }
    }

    // Windows.onload에서 fetchcontent1의 내용을 로드하기
    window.onload = function() {
        toggleFetchContent('fetchContent1', 'test/managementplanning');
    };