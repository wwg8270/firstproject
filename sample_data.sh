#!/bin/bash

function sample_data()
{
  hive -e "
  set mapred.job.priority=HIGH;
  select tag_name,tag_image_name,ctype,sum(so_ad_cost) from hdp_unionad.pc_dsp_join_log where is_rtb=1 and viewed = 1 and day='20190417' and ctype in ('21','22','23','24','25','26') and so_ad_cost > 0 group by tag_name,tag_image_name,ctype limit 100000
  " > sample_datas
}
function gen_html()
{
  echo "<html><head></head><body><table border="1">"  > sample.html
  awk -F'\t' '{print "<tr><td>",$1,$2,$3,$4, "\"</td><td> \"<td><img src=\"", "http://p0.qhimg.com/"$2, "\"style=\"width: 300px; height: 300px;\"></td> </td></tr>"}' 200_data >> sample.html
}
#sample_data
gen_html
