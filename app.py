from flask import Flask, render_template

app = Flask(__name__)

# @app.route('/') 告诉Flask当用户访问网站根目录（'/'）时
@app.route('/')
def home():
    """
    主页视图函数。
    """
    # render_template 会自动在 'templates' 文件夹中寻找 'index.html' 文件
    # 并将其内容作为响应返回给浏览器
    return render_template('index.html')


# 只有当这个文件被直接运行时（而不是被导入时），才会执行 app.run()
if __name__ == '__main__':
    # 启动开发服务器
    # debug=True 意味着服务器会在代码更改后自动重启
    # port=5000 指定服务器运行在 5000 端口
    app.run(debug=True, port=5000)
