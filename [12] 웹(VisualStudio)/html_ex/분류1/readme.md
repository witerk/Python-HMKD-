# 파이썬 버전
python --version 

# 파이썬 위치
where python 

# 가상환경 생성
Window : python -m venv myenv
Linux : python3 -m venv myenv

(가상환경 생성: 이런 식으로 사용)
C:\Users\h\AppData\Local\Programs\Python\Python310\python.exe -m venv myenv

# 가상환경 접속
myenv\Scripts\activate 

# 로컬에 있는 파일 설치(해당 경로에 가서 가상환경 접속해야 함)
pip install -r requirements.txt 

# 업데이트
python.exe -m pip install --upgrade pip

# 이 환경을 다른 데서 그대로 사용하고 싶을 때(설정 유지)
pip freeze > requirements.txt

# 설치 파일 목록
pip list 