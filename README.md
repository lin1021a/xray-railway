# Xray (VLESS + WS + TLS) on Railway

架构：客户端 --TLS--> Railway 边缘（HTTPS 终结）--WS 明文--> xray 容器

## 环境变量（Railway 服务里设置）

- `XRAY_UUID` = 见 uuid.txt（已生成）
- `XRAY_WS_PATH` = `ray`（可改任意字符串，改后同步改 gen_sub.py 里的 WS_PATH）
- `PORT` 由 Railway 自动注入，不要手动设

## 部署

1. 用自己的账号登录 Railway（邮箱或 GitHub），新建 Project → Deploy from GitHub repo 或用 Railway CLI 上传本目录
2. 服务根目录指向本目录，Railway 会自动识别 Dockerfile
3. 在 Variables 里加上面两个变量
4. Settings → Networking → Generate Domain，拿到 `*.up.railway.app` 域名
5. 本地跑：`python3 gen_sub.py <域名>`，生成小火箭订阅链接 + 二维码

## 拨测

- `curl -i https://<域名>/ray` 返回 400/426（WebSocket 升级要求）即表示 WS 路径通了
- 小火箭导入订阅后测速/连通性测试通过即完成
