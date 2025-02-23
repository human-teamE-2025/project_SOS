<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
#upload-step1 {
    background: #222;
    padding: 20px;
    border-radius: 10px;
    color: white;
    max-width: 800px;
    margin: auto;
}

#upload-step1 h2 {
    text-align: center;
}

#music-upload-step1 {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

#music-upload-step1 input,
#music-upload-step1 select {
    padding: 10px;
    border-radius: 5px;
    border: 1px solid #555;
    background: #333;
    color: white;
    font-size: 16px;
    transition: 0.3s ease;
}

#music-upload-step1 input:focus,
#music-upload-step1 select:focus {
    border-color: #FFC107;
    outline: none;
}

#music-upload-step1 button {
    background: #FFC107;
    color: black;
    padding: 10px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    transition: 0.3s ease;
}

#music-upload-step1 button:disabled {
    background: #777;
    cursor: not-allowed;
}

#music-upload-step1 button:hover:enabled {
    background: #FFB300;
}

</style>

<div id="upload-step1">
    <h2>🎵 노래 업로드 (1단계)</h2>
    <form id="music-upload-step1" enctype="multipart/form-data">
    
            <label for="music-file">음악 파일 업로드 (MP3, WAV, AAC, 10MB 이하):</label>
        <input type="file" id="music-file" name="music-file" accept=".mp3, .wav, .aac" required>
        <!-- ✅ 파일 정보 표시 -->
<p class="file-info" id="file-info"></p>
        
        
        <label for="song-title">제목:</label>
        <input type="text" id="song-title" name="song-title" required>

        <label for="artist">아티스트:</label>
        <input type="text" id="artist" name="artist" required>

        <label for="genre">장르:</label>
        <select id="genre" name="genre" required>
            <option value="">-- 장르 선택 --</option>
            <option value="pop">팝</option>
            <option value="rock">락</option>
            <option value="hiphop">힙합</option>
            <option value="jazz">재즈</option>
            <option value="classical">클래식</option>
        </select>





        <!-- ✅ 버튼을 폼 내부에 포함 -->
        <div class="form-buttons">
            <button type="submit" id="next-step">다음 단계</button>
            <button type="button" id="back-to-main">취소</button>
        </div>
    </form>
</div>
<script>
function initUploadFormEvents() {
    console.log("🚀 Step1 이벤트 리스너 등록 완료");

    // ✅ DOM 요소 가져오기
    const form = document.getElementById("music-upload-step1");
    const nextStepButton = document.getElementById("next-step");
    const backToMainButton = document.getElementById("back-to-main");
    const fileInput = document.getElementById("music-file");
    const songTitleInput = document.getElementById("song-title");
    const fileInfoDisplay = document.getElementById("file-info");

    // ✅ 필수 요소 검증
    if (!form || !nextStepButton || !backToMainButton || !fileInput || !songTitleInput || !fileInfoDisplay) {
        console.error("❌ 필수 요소가 로드되지 않음");
        return;
    }

    // ✅ 취소 버튼 이벤트
    backToMainButton.addEventListener("click", function () {
        if (document.referrer) {
            history.back();
        } else {
            window.location.href = "${pageContext.request.contextPath}/index.jsp";
        }
    });

    // ✅ 파일 선택 이벤트 핸들러
    function handleFileSelect() {
        if (fileInput.files.length === 0) {
            fileInfoDisplay.innerHTML = `<span style="color: red;">❌ 파일을 선택하세요.</span>`;
            return;
        }

        const file = fileInput.files[0];
        const fileName = file.name.replace(/\.[^/.]+$/, ""); // 확장자 제거한 파일명
        const fileSizeMB = (file.size / (1024 * 1024)).toFixed(2) + " MB"; // MB 단위 변환

        // ✅ 허용된 확장자 체크
        const allowedExtensions = ["mp3", "wav", "aac"];
        const fileExtension = file.name.split(".").pop().toLowerCase();
        if (!allowedExtensions.includes(fileExtension)) {
            fileInfoDisplay.innerHTML = `<span style="color: red;">❌ 지원되지 않는 파일 형식입니다.</span>`;
            return;
        }

        // ✅ 파일 크기 체크
        if (file.size > 10 * 1024 * 1024) {
            fileInfoDisplay.innerHTML = `<span style="color: red;">❌ 파일 크기가 10MB를 초과합니다.</span>`;
            return;
        }

        // ✅ 제목 자동 입력
        songTitleInput.value = fileName;

        // ✅ "파일 분석 중..." 문구 표시
        fileInfoDisplay.innerHTML = `<span style="color: #FFC107;">파일 분석 중...</span>`;

        // ✅ 오디오 길이 가져오기
        getAudioDuration(file)
            .then(duration => {
                fileInfoDisplay.innerHTML = `길이: ${duration} | 크기: ${fileSizeMB}`;
                console.log(`✅ 오디오 분석 성공 - 길이: ${duration} | 크기: ${fileSizeMB}`);
            })
            .catch(error => {
                console.error("❌ 오디오 분석 실패:", error);
                fileInfoDisplay.innerHTML = `<span style="color: red;">❌ 길이 불러오기 실패</span> | 크기: ${fileSizeMB}`;
            });
    }

    // ✅ 오디오 길이를 MM:SS 형식으로 변환
    function formatDuration(seconds) {
        if (isNaN(seconds) || seconds === 0) return "알 수 없음"; // 예외 처리
        const min = Math.floor(seconds / 60);
        const sec = Math.floor(seconds % 60);
        return `${min}:${sec.toString().padStart(2, "0")}`;
    }

    // ✅ Web Audio API를 사용한 오디오 길이 가져오기
    function getAudioDuration(file) {
        return new Promise((resolve, reject) => {
            try {
                const reader = new FileReader();
                reader.onload = function (event) {
                    const audioContext = new (window.AudioContext || window.webkitAudioContext)();

                    console.log(`🎵 AudioContext State: ${audioContext.state}`);

                    // ✅ AudioContext가 'suspended' 상태일 경우 resume() 실행
                    if (audioContext.state === "suspended") {
                        audioContext.resume().then(() => {
                            console.log("🔄 AudioContext resumed.");
                        });
                    }

                    audioContext.decodeAudioData(event.target.result)
                        .then(buffer => {
                            if (!buffer || isNaN(buffer.duration)) {
                                console.warn("⚠️ Web Audio API가 오디오 길이를 정확히 가져오지 못함.");
                                return fallbackAudioDuration(file, resolve, reject);
                            }
                            resolve(formatDuration(buffer.duration));
                        })
                        .catch(error => {
                            console.error("❌ decodeAudioData() 실패:", error);
                            return fallbackAudioDuration(file, resolve, reject);
                        });
                };

                reader.onerror = function () {
                    console.error("❌ FileReader에서 파일 읽기 실패");
                    reject("파일을 읽는 중 오류 발생");
                };

                reader.readAsArrayBuffer(file);
            } catch (error) {
                console.error("❌ Web Audio API를 사용할 수 없음:", error);
                return fallbackAudioDuration(file, resolve, reject);
            }
        });
    }

    // ✅ `new Audio()` 백업 방식
    function fallbackAudioDuration(file, resolve, reject) {
        try {
            const audio = new Audio(URL.createObjectURL(file));
            audio.addEventListener("loadedmetadata", function () {
                if (!audio.duration || isNaN(audio.duration)) {
                    reject("오디오 길이를 가져올 수 없음");
                } else {
                    resolve(formatDuration(audio.duration));
                }
            });
        } catch (error) {
            console.error("❌ `new Audio()` 방식도 실패함:", error);
            reject("오디오 길이 분석 실패");
        }
    }

    // ✅ 이벤트 리스너 등록
document.getElementById("music-upload-step1").addEventListener("submit", function (event) {
    event.preventDefault();
    
    const formData = new FormData(this);

    fetch("UploadServlet", {
        method: "POST",
        body: formData,
        headers: {
            "Accept": "application/json"  // 서버에서 JSON을 반환하도록 요청
        }
    })
    .then(response => {
        if (!response.ok) {
            throw new Error(`서버 응답 오류: ${response.status}`);
        }
        return response.text();  // JSON으로 변환하기 전, 텍스트로 확인
    })
    .then(text => {
        console.log("📥 서버 응답 (텍스트):", text);  // 응답 확인용 로그

        try {
            return JSON.parse(text);  // JSON 변환
        } catch (error) {
            console.error("❌ JSON 파싱 오류: 응답이 JSON이 아닙니다.", text);
            throw new Error("서버 응답이 올바른 JSON 형식이 아닙니다.");
        }
    })
    .then(data => {
        if (data.success) {
            window.location.href = "step2.jsp"; // step2.jsp로 이동
        } else {
            alert("파일 업로드 실패: " + data.error);
        }
    })
    .catch(error => console.error("❌ Step1 전송 오류:", error));
});

    // ✅ 이벤트 리스너 실행
    
}


// ✅ Step1이 AJAX로 불러와질 때 자동 실행되도록 설정
initUploadFormEvents();

</script>
