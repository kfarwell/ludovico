% verb=`{basename $req_path}
% vdir=$sitedir/_werc/ludovico/$verb

<h1>Streamers %($verb%) things</h1>

%{
echo > $vdir/.index
for(thing in `{ls $vdir | sed '/\/\.[^\/]/d'}) {
    echo `{ls $thing | sed '/\/\.[^\/]/d' | wc -l}^,`{basename $thing} \
         >> $vdir/.index
    tmp=`{sort $vdir/.index}
    echo $tmp > $vdir/.index
}
%}

% for(thing in `{cat $vdir/.index}) {
%     thingf=`{cat $vdir/`{echo $thing | sed 's/.*,//'}^/.formatted}
<a href="%($verb/`{echo $thing | sed 's/.*,//'}%)">
%     if(~ $verb playing) {
%         box=`{wget -O - 'https://api.twitch.tv/kraken/search/games?type=suggest&q='`{echo $thingf | sed 's/ /%20/g'} |
%               jq -r '.games[0].box.medium'}
%         if(! ~ $"box '' && ! ~ $"box null) {
    <img src="%($box%)" />
%         }
%     }
    <h2>%($thingf%)</h2>
    <p>%(`{echo $thing | sed 's/,.*//'} $verb%)</p>
</a>
% }
