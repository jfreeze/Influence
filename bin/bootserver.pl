use IO::Socket;
my $p='4321';
my $s=new IO::Socket::INET(LocalHost=>'0.0.0.0',LocalPort=>$p,Proto=>'tcp',Listen=>1,Reuse=>1,);
die "Could not create socket: $!\n" unless $s;
my $c=$s->accept();
while(<$c>){
  if ($_ == "_close_"){close($s);}
  print `$_`;
}