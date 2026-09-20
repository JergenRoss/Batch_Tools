ffmpeg -i "2023-03-09 23-13-44.mkv" -filter_complex ^
"[0:v]trim=start='00\:00\:00':end='00\:01\:00',setpts=PTS-STARTPTS[1v];^
 [0:a]atrim=start='00\:00\:00':end='00\:01\:00',asetpts=PTS-STARTPTS[1a];^
 [0:v]trim=start='00\:01\:25',setpts=PTS-STARTPTS[2v];^
 [0:a]atrim=start='00\:01\:25',asetpts=PTS-STARTPTS[2a];^
 [1v][1a][2v][2a]concat=a=1[outv][outa]" -map [outv] -map [outa] "test.mkv"
 
rem A special character is escaped by prefixing it with a ‘\’. 
rem example: when format time (HH:MM:SS:end=) can be written (HH\:MM\:SS:end=)
rem ":" is separated argument instead format time with "\:"