sudo apt-get update
sudo apt-get upgrade -y
sudo apt install ffmpeg -y
sudo apt-get install unzip
sudo apt-get install build-essential libpcre3 libpcre3-dev libssl-dev -y
mkdir ~/working
cd ~/working
wget http://nginx.org/download/nginx-1.11.6.tar.gz
wget https://github.com/arut/nginx-rtmp-module/archive/master.zip
tar -zxvf nginx-1.11.6.tar.gz 
unzip master.zip
cd nginx-1.11.6
./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master 
make
sudo make install
sudo wget https://raw.github.com/JasonGiedymin/nginx-init-ubuntu/master/nginx -O /etc/init.d/nginx
sudo chmod +x /etc/init.d/nginx
sudo update-rc.d nginx defaults
sudo service nginx start
sudo service nginx stop
echo -e "rtmp {\n
    server {\n
            listen 1935;\n
            chunk_size 4096;\n
            application trancecode {\n
                    live on;\n
                    record off;\n
                    exec ffmpeg -i "rtmp://127.0.0.1/trancecode/stream" -s 1600x900 -r 48 -c:v libx264 -preset faster -profile:v high -g 96 -x264-params \"bitrate=8400:vbv_maxrate=8400:vbv_bufsize=8400:threads=0:bframes=3:keyint=96:keyint_min=96:nal_hrd=cbr:scenecut=0:rc=cbr:force_cfr=1\" -sws_flags lanczos -pix_fmt yuv420p -c:a copy -f flv -strict normal "rtmp://127.0.0.1/liveout";\n
            }\n
            application trancecode {\n
                    live on;\n
                    record off;\n
                    push rtmp://live-fra05.twitch.tv/app/{stream_key};\n
            }\n
     }\n
     
}" >> /usr/local/nginx/conf/nginx.conf
