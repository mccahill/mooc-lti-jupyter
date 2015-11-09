# encoding: UTF-8
 
# Simple password generation in Ruby.
#
# Generate reasonably secure random passwords of any chosen length,
# designed to be somewhat easy for humans to read and remember.
# Each password has a capitalized letter and a digit.
#
# Example:
#
#   pwgen = PasswordGenerator.new
#   for i in 0..10
#     puts pwgen.generate(8)
#   end
#
class PasswordGenerator
 
  # These are the koremutake syllables, plus the most common 2 and 3 letter 
  # syllables taken from the most common 5,000 words in English, minus a few
  # syllables removed so that combinations cannot generate common rude
  # words in English.
  SYLLABLES = %w(ba be bi bo bu by da de di do du dy fe fi fo fu fy ga ge gi
    go gu gy ha he hi ho hu hy ja je ji jo ju jy ka ke ko ku ky la le li lo 
    lu ly ma me mi mo mu my na ne ni no nu ny pa pe pi po pu py ra re ri ro 
    ru ry sa se si so su sy ta te ti to tu ty va ve vi vo vu vy bra bre bri 
    bro bru bry dra dre dri dro dru dry fra fre fri fro fru fry gra gre gri 
    gro gru gry pra pre pri pro pru pry sta ste sti sto stu sty tra tre er 
    ed in ex al en an ad or at ca ap el ci an et it ob of af au cy im op co 
    up ing con ter com per ble der cal man est for mer col ful get low son 
    tle day pen pre ten tor ver ber can ple fer gen den mag sub sur men min 
    out tal but cit cle cov dif ern eve hap ket nal sup ted tem tin tro tro)
 
  def initialize
    srand
  end
 
  def generate(length)
    result = ''
    while result.length < length
      syl = SYLLABLES[rand(SYLLABLES.length)]
      result += syl
    end
    result = result[0,length]
    # Stick in a digit
    dpos = rand(length)
    result[dpos,1] = rand(9).to_s
    # Make a letter capitalized
    cpos = rand(length)
    result[cpos,1] = result[cpos,1].swapcase
    return result
  end
end