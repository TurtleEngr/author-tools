s/\&lt;/\</g
s/\&gt;/>/g
#s/\$\([A-Z]\)/\1/g
s/<p>\(<blockquote[^>]*>\)/\1<p>/
s;</blockquote></p>;</p></blockquote>;
s/\&quot;/"/g
s;<p></p>;;g
s;<p><div ;<div ;g
s;</div></p>;</div>;g
s;<p><h4>;<h4>;g
s;</h4></p>;</h4>;g
s|<p>&lt;h4&gt;|<h4>|g
s|&lt;/h4&gt;</p>|</h4>|g
s;{\(.\);<cite>{\1;g
s;\(.\)};\1}</cite>;g
