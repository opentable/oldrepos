{
  addressable = {
    dependencies = ["public_suffix"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0viqszpkggqi8hq87pqp0xykhvz60g99nwmkwsb0v45kc2liwxvk";
      type = "gem";
    };
    version = "2.5.2";
  };
  faraday = {
    dependencies = ["multipart-post"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "14lg0c4bphk16rccc5jmaan6nfcvmy0caiahpc61f9zfwpsj7ymg";
      type = "gem";
    };
    version = "0.15.2";
  };
  multipart-post = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "09k0b3cybqilk1gwrwwain95rdypixb2q9w65gd44gfzsd84xi1x";
      type = "gem";
    };
    version = "2.0.0";
  };
  octokit = {
    dependencies = ["sawyer"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1ssn5iyax07a22mvmj0y45bfy8ali129bl1qmasp6bcg03bvk298";
      type = "gem";
    };
    version = "4.9.0";
  };
  public_suffix = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1x5h1dh1i3gwc01jbg01rly2g6a1qwhynb1s8a30ic507z1nh09s";
      type = "gem";
    };
    version = "3.0.2";
  };
  sawyer = {
    dependencies = ["addressable" "faraday"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0sv1463r7bqzvx4drqdmd36m7rrv6sf1v3c6vswpnq3k6vdw2dvd";
      type = "gem";
    };
    version = "0.8.1";
  };
}