## Topic 분류

# 가상환경 설정
where python

C:\Users\h\AppData\Local\Programs\Python\Python310\python.exe -m venv myenv

pip install -r requirements.txt


가상환경을 생성
W : python -m venv myenv

생성된 가상환경을 활성화
W : .\myenv\Scripts\activate

## index.html

이 코드는 웹 페이지를 생성하는 HTML 문서입니다. 페이지는 문장을 입력하면 해당 문장의 주제를 분류하는 기능을 제공합니다. 분류 작업은 서버의 API를 호출하여 수행하며, 결과는 웹 페이지에 표시됩니다.

다음으로 자세히 살펴보겠습니다:

HTML
HTML 코드는 웹 페이지의 구조를 정의합니다.

<head> 태그 내에는 페이지에 필요한 메타데이터와 외부 CSS, JavaScript 라이브러리를 포함합니다.
<body> 태그 내에는 실제 웹 페이지의 내용이 위치합니다. 이 경우에는 Bootstrap 프레임워크를 사용하여 카드 형식의 UI를 만들었습니다. 카드에는 헤더, 본문, 입력 필드, 버튼 등이 있습니다.
CSS

<style> 태그 내에는 페이지의 디자인을 결정하는 CSS 스타일이 있습니다. 여기서는 body, container, card 등의 클래스에 대한 스타일을 정의했습니다.
JavaScript

<script> 태그 내에는 웹 페이지의 동작을 결정하는 JavaScript 코드가 있습니다. 이 경우에는 api_call 함수를 정의하고 있습니다.
api_call 함수는 사용자가 "토픽 분류" 버튼을 클릭하면 실행됩니다. 이 함수는 입력된 문장을 가져와서 서버의 API에 POST 요청을 보냅니다. API의 응답을 받으면, 그 결과를 웹 페이지에 표시합니다.
기타

이 페이지는 jQuery와 Bootstrap을 사용합니다. jQuery는 JavaScript 라이브러리로, DOM 조작과 AJAX 요청 등을 보다 쉽게 수행할 수 있게 도와줍니다. Bootstrap은 CSS 프레임워크로, 레이아웃, 버튼, 카드 등 다양한 컴포넌트의 스타일을 미리 정의해둡니다.
사용 예는 다음과 같습니다:

사용자가 웹 페이지에 접속하면, 카드 형식의 UI가 표시됩니다.
사용자가 텍스트 영역에 문장을 입력하고, "토픽 분류" 버튼을 클릭합니다.
페이지는 서버의 API에 POST 요청을 보내고, 응답을 기다립니다.
API의 응답이 도착하면, 그 결과가 페이지에 표시됩니다. 이 결과는 문장의 주제를 나타냅니다.



