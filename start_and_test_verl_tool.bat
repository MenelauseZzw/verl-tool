@echo off
REM ----------------------------
REM One-click start verl_tool server + test google_search tool
REM ----------------------------

REM --- 配置 ---
set host=localhost
set port=5000
set tool_type=google_search
set SERPER_API_KEY=2c2fd0d8daf7beb9127840aa13f058a7a05e6699
set workers_per_tool=4
set log_file=verl_tool.log

REM --- 启动服务器 ---
echo Starting verl_tool server in background...
start "" cmd /c python -m verl_tool.servers.serve --host %host% --port %port% --tool_type %tool_type% --workers_per_tool %workers_per_tool% ^> %log_file% 2^>^&1

REM --- 等待服务器启动 ---
echo Waiting 5 seconds for server to initialize...
timeout /t 5 /nobreak >nul

REM --- 测试 google_search 工具 ---
echo Testing google_search tool...
python -m verl_tool.servers.tests.test_google_search_tool test_google_search --url=http://localhost:%port%/get_observation

echo Done. Check %log_file% for server logs.
pause
