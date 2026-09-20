@ECHO OFF
echo for %%A in (*.mp4) do (
	ffmpeg -i %%A.mp4 -vcodec h264 -acodec mp2 %%A.mp4
	)

Pause