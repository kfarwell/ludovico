% verb=`{echo $req_path | sed 's/.*(playing|making|watching|doing).*/\1/'}
% thing=`{basename $req_path}
% tdir=$sitedir/_werc/ludovico/$verb/$thing

<h1>Streamers %($verb%) %(`{cat $tdir/.formatted}%)</h1>

%{
echo > $tdir/.index
for(streamer in `{ls $tdir | sed '/\/\.[^\/]/d'}) {
    echo `{cat $streamer/viewers}^,`{basename $streamer} >> $tdir/.index
    tmp=`{sort $tdir/.index}
    echo $tmp > $tdir/.index
}
%}

% for(streamer in `{cat $tdir/.index}) {
<a href="%(`{cat $tdir/`{echo $streamer | sed 's/.*,//'}^/url}%)">
    <h2>%(`{cat $tdir/`{echo $streamer | sed 's/.*,//'}^/formatted}%)</h2>
    <p>%(`{echo $streamer | sed 's/,.*//'} watching%)</p>
</a>
% }
