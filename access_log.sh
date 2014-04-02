#!/bin/bash
#by Lia
#写一个脚本:
#1、下载文件 /var/log/nginx/access_log 至 /tmp 目录;
#2、分析并显示 /tmp/access_log 文件中位于行首的 IP 中出现次数最多的前 5 个,并说明每 一个出现了多少次;
#3、取出 /tmp/access_log 文件中以 http:// 开头,后面紧跟着一个域名或 IP 地址的字符串, 比如:http://www.linux.com/install/images/style.css 这个串的http://www.linux. com 的部分;而后显示出现次数最多的前 5 个;
#要求:第 2、3 功能各以函数的方式实现;

access_log_dir=/tmp

function getAccesslog()
{
  wget -c -t 5 http://domainname.com/path/to/access_log -P $access_log_dir
  if [ $? eq 0]; then
    echo "wget download the access_log file wrong !"
    exit 1;
  fi
}

function getCount()
{
  echo "IP counts and counts the five forward"
  awk '{a[$1]++;} END {for (i in a) print i "  count:  " a[i];}' $access_log_dir/access_log | sort -k3 -nr |head -n 5
}

function getHttp()
{
  echo "list http haed and count the five forward"
  awk '{a[$11]++;} END {for (i in a) print i "  counts:  " a[i];}' $access_log_dir/access_log |grep "http://" | sort -k3 -nr |head -n 5
}

echo "Now downloading access_log file ..."
#getAccesslog
echo "The access_log file downloaded, then anylize the file ..."
sleep 2
getCount
getHttp
echo "Done !"
exit 0
