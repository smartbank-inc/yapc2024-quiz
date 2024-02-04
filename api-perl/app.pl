use strict;
use warnings;
use utf8;

use Mojolicious::Lite;
use Mojo::JSON qw(decode_json encode_json);

my $balance = 0;
my @shop_names = ();

post '/init' => sub {
    my $c = shift;
    $balance = 100000; # 所持金10万円からスタート！
    @shop_names = ();  # 訪問した店舗名を記録して思い出にする！
    return $c->render(status => 200, text => '');
};

post '/payments' => sub {
    my $c = shift;
    my $data = $c->req->json;

    $balance -= $data->{amount};
    push @shop_names, $data->{shop_name};

    return $c->render(status => 201, text => '');
};

get '/summary' => sub {
    my $c = shift;

    @shop_names = sort @shop_names;

    my $response = {
        balance    => $balance,
        shop_names => \@shop_names
    };

    return $c->render(json => $response);
};

app->start;
