#!/usr/bin/ruby -Ke
# Original File: http://www.unixuser.org/~haruyama/software/canna2skk/canna2skk.rb
# $Id: canna2skk.rb,v 1.10 2003/12/13 00:34:06 haruyama Exp $
# modify: 2012/09/26 Kanatsu MINORU
# getopts -> optparse
#
# ruby -Ke canna2skk.rb 2ch.t | sort -u |skkdic-sort > SKK-JISYO.2ch
# のようにお使いください
# コマンドラインオプションとして -m を指定すると末尾がひらがなの単語は出力しません
#require 'jcode'

# require 'getopts'
# 
# getopts('m')
require 'optparse'
opt = OptionParser.new
OPT_m = opt.getopts('m')


$HIRAGANA_NOMI = 0
$HIRAGANA_IGAI_KOMI = 1
$OKURI_ARI = 2


def hiragana?(str)
  if /^[ぁ-んー]+$/ =~ str
    return $HIRAGANA_NOMI,nil,nil
  elsif /^(.*?)([ぁ-んー])[ぁ-んー]*$/ =~str

      return $OKURI_ARI,$1,nil
#けっきょく以下の解析は使っていない
=begin
    tmp = $1
    case $2
    when /[ぁ]/,/[あ]/
      return $OKURI_ARI,tmp,'a'
    when /[ぃ]/,/[い]/
      return $OKURI_ARI,tmp,'i'
    when /[ぅ]/,/[う]/
      return $OKURI_ARI,tmp,'u'
    when /[ぇ]/,/[え]/
      return $OKURI_ARI,tmp,'e'
    when /[ぉ]/,/[お]/
      return $OKURI_ARI,tmp,'o'
    when /[か-こ]/
      return $OKURI_ARI,tmp,'k'
    when /[さ-す]/
      return $OKURI_ARI,tmp,'s'
    when /[た-と]/,/[っ]/
      return $OKURI_ARI,tmp,'t'
    when /[な-の]/,/[ん]/
      return $OKURI_ARI,tmp,'n'
    when /[ふ]/
      return $OKURI_ARI,tmp,'h','f'
    when /[は-ほ]/
      return $OKURI_ARI,tmp,'h'
    when /[ま-も]/
      return $OKURI_ARI,tmp,'m'
    when /[や-よ]/
      return $OKURI_ARI,tmp,'y'
    when /[ら-ろ]/
      return $OKURI_ARI,tmp,'r'
    when /[わ-を]/
      return $OKURI_ARI,tmp,'w'
    when /[が-ご]/
      return $OKURI_ARI,tmp,'g'
    when /[じ]/
      return $OKURI_ARI,tmp,'z','j'
    when /[ざ-ぞ]/
      return $OKURI_ARI,tmp,'z'
    when /[だ-ど]/
      return $OKURI_ARI,tmp,'d'
    when /[ば-ぼ]/
      return $OKURI_ARI,tmp,'b'
    when /[ぱ-ぽ]/
      return $OKURI_ARI,tmp,'p'
    end
=end
  else
    return $HIRAGANA_IGAI_KOMI,nil,nil
  end
end



while line=gets
  if /^#/=~line 
      next
  end
  line.strip!
  array=line.split(/\s+/)
  yomi = array.shift
  type = nil
  array.each{ |e|
    if /^#([^*]+)/ =~ e
	type = $1
    else

      if type == nil
	STDERR.print 'error line ' +  "#{$.}" + ':'  + line + "\n"
	exit
      end
      
      hira,head,okuri=hiragana?(e)
      if hira == $HIRAGANA_NOMI
	next
      elsif hira== $OKURI_ARI
	# 単純にできなさそうだし とりあえず無視
	if $OPT_m
	  next
	end
      end
      case type
      when 'B5','B5r'
	if  hira != $OKURI_ARI
	  print yomi + "b /" +e + "/\n"
	  print yomi + "n /" +e + "/\n"
	end
      when 'C5r'
	if  hira != $OKURI_ARI
	  print yomi + "k /" +e + "/\n"
	  print yomi + "i /" +e + "/\n"
	  print yomi + "t /" +e + "/\n"
	end
      when 'D2KY'
	# Thanks: Project Heke
	if  hira != $OKURI_ARI
	  print yomi + "i /" +e + "/\n"
	end
      when 'G5','G5r'
	if  hira != $OKURI_ARI
	  print yomi + "g /" +e + "/\n"
	  print yomi + "i /" +e + "/\n"
	end
      when 'K5','K5r'
	if  hira != $OKURI_ARI
	  print yomi + "k /" + e + "/\n"
	  print yomi + "i /" + e + "/\n"
	end
      when 'KS'
	if  hira != $OKURI_ARI
	  print yomi + "r /"  +e + "/\n"
	end
      when 'KSr'
	if  hira != $OKURI_ARI
	  print yomi + "r /"  +e + "/\n"
	end
	print yomi + " /"  +e + "/\n"
      when 'KY'
	if  hira != $OKURI_ARI
	  print yomi + "k /"  +e + "/\n"
	  print yomi + "i /"  +e + "/\n"
	end
      when 'KYT'	
	if  hira != $OKURI_ARI
	  print yomi + "k /"  +e + "/\n"
	  print yomi + "i /"  +e + "/\n"
	end
	print yomi + " /"  +e + "/\n"
      when 'KYU'
	if  hira != $OKURI_ARI
	  print yomi + " /"  +e + "/\n"
	end
      when 'KYme'
	if  hira != $OKURI_ARI
	  print yomi + "k /"  +e + "/\n"
	  print yomi + "i /"  +e + "/\n"
	  print yomi + "m /"  +e + "/\n"
	end
      when 'KYmi'
	if  hira != $OKURI_ARI
	  print yomi + "k /"  +e + "/\n"
	  print yomi + "i /"  +e + "/\n"
	end
      when 'KYmime'
	if  hira != $OKURI_ARI
	  print yomi + "k /"  +e + "/\n"
	  print yomi + "i /"  +e + "/\n"
	end
	print yomi + " /"  +e + "/\n"
      when 'L5'
	if  hira != $OKURI_ARI
	  print yomi + "i /"  +e + "/\n"
	  print yomi + "r /"  +e + "/\n"
	  print yomi + "t /"  +e + "/\n"
	end
      when 'M5','M5r'
	if  hira != $OKURI_ARI
	  print yomi + "m /"  +e + "/\n"
	end
      when 'N5','N5r'
	if  hira != $OKURI_ARI
	  print yomi + "n /"  +e + "/\n"
	end
      when 'R5','R5r'
	if  hira != $OKURI_ARI
	  print yomi + "r /"  +e + "/\n"
	  print yomi + "t /"  +e + "/\n"
	end
      when 'S5','S5r','SX'
	if  hira != $OKURI_ARI
	  print yomi + "s /"  +e + "/\n"
	end
      when 'T5','T5r'
	if  hira != $OKURI_ARI
	  print yomi + "t /"  +e + "/\n"
	end
      when 'U5','U5r'	
	if  hira != $OKURI_ARI
	  print yomi + "w /"  +e + "/\n"
	  print yomi + "i /"  +e + "/\n"
	  print yomi + "u /"  +e + "/\n"
	  print yomi + "e /"  +e + "/\n"
	  print yomi + "o /"  +e + "/\n"
	  print yomi + "t /"  +e + "/\n"
	end
      when 'W5','W5r'	
	if  hira != $OKURI_ARI
	  print yomi + "w /"  +e + "/\n"
	  print yomi + "i /"  +e + "/\n"
	  print yomi + "u /"  +e + "/\n"
	  print yomi + "e /"  +e + "/\n"
	  print yomi + "o /"  +e + "/\n"
	  print yomi + "t /"  +e + "/\n"
	end
      when 'ZX'
	if  hira != $OKURI_ARI
	  print yomi + "z /"  +e + "/\n"
	end
      when 'aru'
	if  hira != $OKURI_ARI
	  print yomi + "r /"  +e + "/\n"
	end
      when 'kxo'
	if  hira != $OKURI_ARI
	  # こい
	  print yomi + "i /"  +e + "/\n"	
	end
      when 'kxi'
	if  hira != $OKURI_ARI
	  # きた
	  print yomi + "t /"  +e + "/\n"
	end
      when 'kxure','kxuru'	
	# 見てくる,見て来る,見てくれ,見て来れ
      else
	print yomi + " /" + e + "/\n"
      end


    end
  }



end
