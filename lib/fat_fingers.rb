class String

  # Internal: Check a given string for misspelled TLDs and misspelled domains from popular e-mail providers.
  #
  # Examples
  #
  #   "joe@gmail.cmo".clean_up_typoed_email
  #   # => "joe@gmail.com"
  #
  #   "joe@yaho.com".clean_up_typoed_email
  #   # => "joe@yahoo.com"
  #
  # Returns the cleaned String.
  def clean_up_typoed_email
    downcase.
    remove_invalid_characters.
    fix_transposed_periods.
    fix_coms_with_appended_letters.
    clean_up_funky_coms.
    clean_up_funky_nets.
    clean_up_funky_orgs.
    clean_up_gmail.
    clean_up_hotmail.
    clean_up_yahoo.
    clean_up_other_providers.
    add_a_period_if_they_forgot_it
  end

protected

  def remove_invalid_characters
    gsub(/(\s|\#|\'|\"|\\)*/, "").
    gsub(/(\,|\.\.)/, ".").
    gsub("@@", "@")
  end

  def fix_transposed_periods
    gsub(/c\.om$/, ".com").
    gsub(/n\.et$/, ".net")
    # can't do "o.gr" => ".org", as ".gr" is a valid TLD
  end

  def fix_coms_with_appended_letters
    gsub(/\.couk$/, ".co.uk").
    gsub(/\.com(.)*$/, ".com").
    gsub(/\.co[^op]$/, ".com")
  end

  def clean_up_funky_coms
    gsub(/\.c*(c|i|l|m|n|o|p|0)*m+o*$/,".com").
    gsub(/\.(c|v|x)o+(m|n)$/,".com")
  end

  def clean_up_funky_nets
    gsub(/\.n*t*e*t*$/, ".net")
  end

  def clean_up_funky_orgs
    gsub(/\.o+g*r*g*$/, ".org") # require the o, to not false-positive .gr e-mails
  end

  def clean_up_gmail
    gsub(/@g(n|m)*(a|i|l)+m*(a|i|l)*\./,"@gmail.")
  end

  def clean_up_hotmail
    gsub(/@h(o|p)*to*m*(a|i|l)*\./,"@hotmail.")
  end

  def clean_up_yahoo
    gsub(/@y*a*h*a*o*\./,"@yahoo.")
  end

  def clean_up_other_providers
    gsub(/@coma*cas*t.net/,"@comcast.net").
    gsub(/@sbcgloba.net/, "@sbcglobal.net")
  end

  def add_a_period_if_they_forgot_it
    gsub(/([^\.])(com|org|net)$/, '\1.\2')
  end

end