from flask import Flask, request, jsonify, render_template
from flask_cors import CORS
import deploy


def get_web_service_app(inference_fn):

    app = Flask(__name__)
    CORS(app)

    @app.route('/')
    def index():
        return render_template('index.html')

    @app.route('/api', methods=['POST'])
    def api():
        data = request.json
        if "sentence" not in data:
            return jsonify({"error": "No sentence field in the JSON data"}), 400
        sentence = data["sentence"]
        if not isinstance(sentence, str):
            return jsonify({"error": "sentence field must be a string"}), 400
        output_data = inference_fn(sentence)
        response = jsonify(output_data)
        return response

    return app

if __name__ == '__main__':
    # inference_function은 실제 추론 함수를 참조해야 합니다.
    app = get_web_service_app(deploy.inference_fn)
    app.run(debug=True)  # debug=True로 설정하면 개발 중에 발생하는 오류를 쉽게 볼 수 있습니다.
    # app.run(host='127.0.0.1', port=80, debug=False)
