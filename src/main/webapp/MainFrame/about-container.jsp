<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/about-container.css">


<div id="main-container">
			<%@ include file="./left-nav.jsp" %>
    <div id="main-con">
        <!-- 항목 리스트 -->
        <div class="column">
            <div class="title-row">
                <div class="title">회사소개</div>
                <button class="toggle-btn">+</button>
            </div>
            <div class="description">
                <p><strong>Song of Senses</strong>는 감각을 깨우는 특별한 경험을 제공하는 브랜드입니다.  
                    음악과 기술이 결합된 혁신적인 서비스를 통해, 사용자들에게 보다 풍부한 감동과 즐거움을 선사합니다.  
                    당사는 글로벌 시장에서 최고의 음악 스트리밍 및 콘텐츠 제공을 목표로 하며,  
                    지속적인 연구 개발을 통해 사용자의 만족도를 높이는 데 집중하고 있습니다.</p>
            </div>
        </div>

        <div class="column">
            <div class="title-row">
                <div class="title">제휴안내</div>
                <button class="toggle-btn">+</button>
            </div>
            <div class="description">
                <p>당사는 다양한 기업 및 아티스트와 협력하여 더욱 풍부한 음악 경험을 제공합니다.  
                    Song of Senses와 제휴를 원하시는 경우, 공식 웹사이트의 제휴 문의 양식을 통해 신청해 주시기 바랍니다.</p>
                <ul>
                    <li>📌 콘텐츠 제공 제휴 (음원, 비디오, 팟캐스트 등)</li>
                    <li>📌 광고 및 마케팅 협업</li>
                    <li>📌 기업 맞춤형 서비스 제공</li>
                </ul>
                <p>제휴 문의: <a href="mailto:partnership@songofsenses.com">partnership@songofsenses.com</a></p>
            </div>
        </div>

        <div class="column">
            <div class="title-row">
                <div class="title">광고안내</div>
                <button class="toggle-btn">+</button>
            </div>
            <div class="description">
                <p>Song of Senses는 다양한 광고 상품을 제공하여 기업 및 브랜드의 홍보 효과를 극대화할 수 있도록 돕습니다.  
                    맞춤형 광고 캠페인을 통해 잠재 고객에게 효율적으로 도달하세요.</p>
                <ul>
                    <li>🎧 오디오 광고</li>
                    <li>📺 비디오 광고</li>
                    <li>📱 배너 및 네이티브 광고</li>
                </ul>
                <p>광고 문의: <a href="mailto:ads@songofsenses.com">ads@songofsenses.com</a></p>
            </div>
        </div>

        <div class="column">
            <div class="title-row">
                <div class="title">이용약관</div>
                <button class="toggle-btn">+</button>
            </div>
            <div class="description">
                <p><strong>제1조 (목적)</strong></p>
                <p>본 약관은 Song of Senses(이하 "회사")가 제공하는 서비스(이하 "서비스")의 이용 조건 및 절차를 규정합니다.</p>

                <p><strong>제2조 (이용계약의 성립)</strong></p>
                <p>이용자는 본 약관에 동의하는 것을 조건으로 회원가입을 신청할 수 있으며, 회사는 이에 대해 승인함으로써 이용계약이 체결됩니다.</p>

                <p><strong>제3조 (서비스 제공 및 변경)</strong></p>
                <p>회사는 이용자에게 안정적인 서비스를 제공하기 위해 최선을 다하며, 필요에 따라 서비스 내용을 변경할 수 있습니다.</p>

                <p><strong>제4조 (회원의 의무)</strong></p>
                <ul>
                    <li>회원은 본 약관 및 관계 법령을 준수해야 합니다.</li>
                    <li>타인의 정보를 부정하게 사용하는 행위를 금지합니다.</li>
                    <li>서비스를 이용하여 불법적인 활동을 하지 않아야 합니다.</li>
                </ul>

                <p><strong>제5조 (서비스 이용 제한)</strong></p>
                <p>회사는 다음과 같은 경우 회원의 서비스 이용을 제한할 수 있습니다.</p>
                <ul>
                    <li>허위 정보를 제공한 경우</li>
                    <li>법령을 위반하거나 공공질서를 해치는 행위를 한 경우</li>
                    <li>다른 이용자의 서비스 이용을 방해하는 경우</li>
                </ul>
            </div>
        </div>

        <div class="column">
            <div class="title-row">
                <div class="title">개인정보처리방침</div>
                <button class="toggle-btn">+</button>
            </div>
            <div class="description">
                <p><strong>1. 수집하는 개인정보 항목</strong></p>
                <p>회사는 다음과 같은 개인정보를 수집할 수 있습니다.</p>
                <ul>
                    <li>이름, 이메일, 전화번호</li>
                    <li>서비스 이용 기록 및 접속 로그</li>
                    <li>결제 정보 및 구매 내역</li>
                </ul>

                <p><strong>2. 개인정보의 수집 및 이용 목적</strong></p>
                <p>회사는 다음과 같은 목적으로 개인정보를 수집 및 이용합니다.</p>
                <ul>
                    <li>회원 관리 및 서비스 제공</li>
                    <li>고객 지원 및 불만 처리</li>
                    <li>맞춤형 광고 및 마케팅</li>
                </ul>

                <p><strong>3. 개인정보의 보유 및 이용 기간</strong></p>
                <p>회사는 이용자의 개인정보를 수집 및 이용 목적이 달성된 후에는 지체 없이 파기합니다.</p>

                <p><strong>4. 개인정보 보호를 위한 기술적 및 관리적 대책</strong></p>
                <p>회사는 이용자의 개인정보 보호를 위해 다음과 같은 조치를 취합니다.</p>
                <ul>
                    <li>데이터 암호화 및 보안 서버 운영</li>
                    <li>개인정보 접근 권한 관리</li>
                    <li>정기적인 보안 점검 및 내부 교육</li>
                </ul>

                <p>더 자세한 내용은 <a href="${pageContext.request.contextPath}/privacy.jsp">개인정보처리방침 전문</a>을 참고하시기 바랍니다.</p>
            </div>
        </div>

        <div class="column">
            <div class="title-row">
                <div class="title">이용정책</div>
                <button class="toggle-btn">+</button>
            </div>
            <div class="description">
                <p>Song of Senses는 건전한 음악 스트리밍 환경을 조성하기 위해 다음과 같은 이용 정책을 운영합니다.</p>
                <ul>
                    <li>저작권 보호 준수</li>
                    <li>불법 콘텐츠 업로드 금지</li>
                    <li>정당한 이용 목적에 맞는 서비스 사용</li>
                </ul>
                <p>회사는 이용 정책을 위반하는 경우, 사전 통보 없이 계정을 제한하거나 삭제할 수 있습니다.</p>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    const columns = document.querySelectorAll('.column');
    let currentOpenIndex = null;

    columns.forEach((column, index) => {
        column.addEventListener('click', function(event) {
            if (!event.target.classList.contains('toggle-btn')) { 
                toggleDescription(index);
            }
        });

        const button = column.querySelector('.toggle-btn');
        button.addEventListener('click', function(event) {
            toggleDescription(index);
            event.stopPropagation(); // 버튼 클릭 시 이벤트 전파 방지
        });
    });

    function toggleDescription(index) {
        const column = columns[index];
        const description = column.querySelector('.description');
        const button = column.querySelector('.toggle-btn');
        const title = column.querySelector('.title');
        title.style.color = "black";
        // 이미 열려있는 경우 닫기
        if (description.classList.contains('show')) {
            closeDescription(index);
            currentOpenIndex = null;
            return;
        }

        // 현재 열린 항목이 있다면 닫기
        if (currentOpenIndex !== null && currentOpenIndex !== index) {
            closeDescription(currentOpenIndex);
        }

        // 새로 열기
        description.classList.add('show');
        column.classList.add('selected');
        button.textContent = "−";
        button.style.transform = "rotate(180deg)"; // ✅ 버튼 회전 효과 추가

        description.style.overflowY = "auto";
        description.style.maxHeight = "600px";

        currentOpenIndex = index;
    }

    function closeDescription(index) {
        const column = columns[index];
        const description = column.querySelector('.description');
        const button = column.querySelector('.toggle-btn');
        const title = column.querySelector('.title');
        title.style.color = "white";
        description.classList.remove('show');
        column.classList.remove('selected');
        button.textContent = "+";
        button.style.transform = "rotate(0deg)"; // ✅ 버튼 원래 상태로 되돌림

        description.style.overflowY = "hidden";
        description.style.maxHeight = "0";
    }
});

</script>
