#!/usr/bin/ruby -Ke
# Original File: http://www.unixuser.org/~haruyama/software/canna2skk/canna2skk.rb
# $Id: canna2skk.rb,v 1.10 2003/12/13 00:34:06 haruyama Exp $
# modify: 2012/09/26 Kanatsu MINORU
# getopts -> optparse
#
# ruby -Ke canna2skk.rb 2ch.t | sort -u |skkdic-sort > SKK-JISYO.2ch
# �Τ褦�ˤ��Ȥ���������
# ���ޥ�ɥ饤�󥪥ץ����Ȥ��� -m ����ꤹ����������Ҥ餬�ʤ�ñ��Ͻ��Ϥ��ޤ���
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
  if /^[��-��]+$/ =~ str
    return $HIRAGANA_NOMI,nil,nil
  elsif /^(.*?)([��-��])[��-��]*$/ =~str

      return $OKURI_ARI,$1,nil
#���ä��礯�ʲ��β��ϤϻȤäƤ��ʤ�
=begin
    tmp = $1
    case $2
    when /[��]/,/[��]/
      return $OKURI_ARI,tmp,'a'
    when /[��]/,/[��]/
      return $OKURI_ARI,tmp,'i'
    when /[��]/,/[��]/
      return $OKURI_ARI,tmp,'u'
    when /[��]/,/[��]/
      return $OKURI_ARI,tmp,'e'
    when /[��]/,/[��]/
      return $OKURI_ARI,tmp,'o'
    when /[��-��]/
      return $OKURI_ARI,tmp,'k'
    when /[��-��]/
      return $OKURI_ARI,tmp,'s'
    when /[��-��]/,/[��]/
      return $OKURI_ARI,tmp,'t'
    when /[��-��]/,/[��]/
      return $OKURI_ARI,tmp,'n'
    when /[��]/
      return $OKURI_ARI,tmp,'h','f'
    when /[��-��]/
      return $OKURI_ARI,tmp,'h'
    when /[��-��]/
      return $OKURI_ARI,tmp,'m'
    when /[��-��]/
      return $OKURI_ARI,tmp,'y'
    when /[��-��]/
      return $OKURI_ARI,tmp,'r'
    when /[��-��]/
      return $OKURI_ARI,tmp,'w'
    when /[��-��]/
      return $OKURI_ARI,tmp,'g'
    when /[��]/
      return $OKURI_ARI,tmp,'z','j'
    when /[��-��]/
      return $OKURI_ARI,tmp,'z'
    when /[��-��]/
      return $OKURI_ARI,tmp,'d'
    when /[��-��]/
      return $OKURI_ARI,tmp,'b'
    when /[��-��]/
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
	# ñ��ˤǤ��ʤ��������� �Ȥꤢ����̵��
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
	  # ����
	  print yomi + "i /"  +e + "/\n"	
	end
      when 'kxi'
	if  hira != $OKURI_ARI
	  # ����
	  print yomi + "t /"  +e + "/\n"
	end
      when 'kxure','kxuru'	
	# ���Ƥ���,�������,���Ƥ���,�������
      else
	print yomi + " /" + e + "/\n"
      end


    end
  }



end
