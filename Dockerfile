FROM python:3.12-slim

# 2. 在容器内部设置一个工作目录
WORKDIR /app

# 3. 复制依赖文件
# 我们只先复制 requirements.txt，这样 Docker 可以缓存已安装的包
# 只有当 requirements.txt 发生变化时，才会重新运行 pip install
COPY requirements.txt .

# 4. 安装依赖
RUN pip install --no-cache-dir -r requirements.txt

# 5. 复制应用代码到工作目录
# 将当前目录(.)的所有内容复制到容器的 /app 目录
COPY . .

# 6. (可选) 设置环境变量
ENV FLASK_APP=app.py

# 7. 暴露端口
# 告诉 Docker 容器内的应用将在 5000 端口上监听
# 这与 gunicorn 的 -b 0.0.0.0:5000 设置相匹配
EXPOSE 5000

# 8. 定义容器启动时运行的命令
# 使用 Gunicorn 运行应用
# -w 4: 启动 4 个 worker 进程 (根据您的服务器CPU核心数调整)
# -b 0.0.0.0:5000: 绑定到所有网络接口的 5000 端口
# app:app: 运行 app.py 文件中的 app 实例
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "app:app"]