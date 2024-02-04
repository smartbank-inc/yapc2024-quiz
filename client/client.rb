eval(%w(require$'net/http';require$'csv';require$'json';require$'digest';require$'base64';;API_HOST$=$ENV.fetch('API_HOST',$'http://localhost:3000');;begin;$
$Net::HTTP.post(URI("#{API_HOST}/init"),$'');rescue$Errno::ECONNREFUSED;$$puts$'Waiting$for$API$server$to$be$ready.';$$sleep$1;$$retry;end;;csv_data$=$File.r
ead(File.expand_path('../requests.csv',$__FILE__));csv_rows$=$CSV.parse(csv_data,$headers:$true);;seen$=${};payload_violation_correct$=$true;csv_rows.each$do
$|row|;$$body$=${$amount:$Integer(row['amount']),$shop_name:$row['shop_name']$}.to_json;$$headers$=${$'Content-Type':$'application/json'$};$$headers['Idempot
ency-Key']$=$row['idempotency_key']$unless$row['idempotency_key'].empty?;$$response$=$Net::HTTP.post(URI("#{API_HOST}/payments"),$body,$headers);;$$unless$ro

w['idempo      tency_k            ey            '].empty?;$$$$i            f$seen. ke     y?(row['i           dempo          tency_key                    '  
  ])$&&          $s               ee              n[ro     w['id          empo  tency    _ke   y']]$         !=$  bo        dy$   &&$re                   s  
  ponse          .c               od              e$!=       $'42        2';     $$$$   $$p     ayloa       d_v   iol      ati     on_co                 rr  
   ect$          =$               fa              lse;        $$$$       en       d;$  $$$       seen       [r     ow[    'id       empo                 te  
   ncy_k         e               y']]             $||=         $bo      dy;       $$e            nd;e      nd;     ;re              spon                se$  
    =$Ne        t:               :HTT             P.ge         t(UR    I("         #{             API_    HOS       T}/              summ               ary  
    "));        re               spon             se_j         son$    =$J         SO             N.pa    rse       (re              spon              se);  
    ;bala       n                ce$=             $res         pons   e_js         on             ['ba    lan       ce'              ];sh              op_n  
     ames      $=               $resp             onse         _jso   n['                          sho   p_na       mes'              ].u             niq.s  
     ort;      di               gest$             =$Di         gest   ::S                          HA25  6.he        xdi              gest            (shop  
     _name     s                .join)            ;;de         f$de  code                          (s);  $$Ba        se6              4.st           rict_d  
     ecode     6                4 (s).            forc         e_en  codi                          ng('  UTF-        8')              ;end           ;;bala  
      nce_     c                o rrec            t$=$         bal   ance                          $>=$  0;sh        op_              corr           e ct$=  
      $dig    es               t  $==$'           dca4         439   3bd1                          49df b6a00        4ff9             d488          30 2c83  
      3be68   e                0   d655           f2a6        5105   df38                          8f43 4af';        poin             ts$=          $  [bal  
       ance   _                c   orre           ct,$      shop_   corre                         ct,$  paylo        ad_v            iola          ti  on_c  
       orrec t]               .c   ount(          &:itself);rank    $=$['                         C',$  'B',$        'A',            $'S'          ][  poin  
       ts];r an               k_   resul          t$=$"%<rank_l     abel>                        s%<ra  nk>s"        $%${           rank_         la   bel:  
        deco d                e(    '44C          Q44O              p44Oz                        44Kv4  4CR')        ,$ra           nk:};         ct   o_co  
        mment$                =     $dec          ode(              '44CQ                       Q1RP4   4GL44        KJ44          Gu5Li         A6    KiA4  
         4CR')               $+     $deco         de([              '44KC                       44GG5   7WC44        KP44          KK44G         g4    oCm'  
         ,$'5                Yq      p44G         L44G              j44Gf                      4oCm4    4Gu44        GL4o         Cm77y         f'     ,$'5  
         Yqp4                4       GR44         Gm44              GP44K                     M44Gm4    4GC44        KK44        GM44Go         44     GG4o  
         Cm44                G       C44KK        44GM              44Go4                     4GG4o     Cm',$        '44G        G44Gh          4      4Gr5  
         YWl5               6S       +44GX        44Gm              44GP4                    4KM44      Cc77y        B'][       point          s]      );ba  
         lanc               e        _resu        lt$=              $deco                   de(b        alanc        e_co      rrec            t       $?$'  
         4pyF               IENUT+OCkuegtO        eUo+               OBi+                   OCi         eaVke        OBhu      OBk            +OBqOOBjOOBp+OB
         jeOB              n++8gfCfkrA='$:        $'4p               2MIE                  NUT           +OBr        +eg      tOe             Uo+OBl+OBpuOBl+
         OBvu              OB         o+OB        ny4u               LvCf                  kr            g=')        ;sh      op             _result$=$decode
         (sho              p          _corr       ect$               ?$'4                  p             yFIO        ioq      u              WVj+OBl+OBn+OBiu
         W6l+              O           Ckua       to+e                iuuO                B              q+io        mOm     M              suOBp+OBjeOBn++8g
         fCfp              b           M='$       :$'4                p2MI               Oi              oquW        Vj+    OB              l+OBn+OBiuW6l+OCk
         uato             +e           iuuOB      q+io                mOmM          s    uO               Bp+       OBj     eO                         BquO  
         Bi+O             B            o+OBn      y4uL                 vCfk         p    Q            =   ');       n$=     $            d             ecod  
         e('C             g             ==')      ;bon                 us_r        e    su           lt   $=$       ran    k$           ==             $'S'  
         $?$d            ec             ode('     4pyF                  IOOD       j    +ODvOODieODouO     DvO     ODie    OCr+ODquOCou+8              gfCf  
         joo=            ')             $+$n$     :$''                  ;pos           t_text$=$"#{dec     ode     ('4    4KP44Gf44GX44GM              5q6L  
         44GZ            44              GT44     Go44                   GM44     G    n44GN44GfQ1RP44      Gu     6LK    h55Sj44Gv')}#{b              alan  
         ce}#            {               deco     de('                   5YaG4  4Gn    44GX44Gf')}#{n        *2   }#{     rank_result}#{               n}#{  
       cto_comm       ent}#{           n*2}#{bo nus_resu                  lt}#{bal     ance_result}#{        n}#{sho      p_result}#{n*2             }#{decod
       e('I3lhc       GNqYXB           hbiAjQ1R P44KS56C                     055      Sj44GL44KJ5pWR4          4GK       44GG44OB44Oj44O             s44Oz44K

4IA==')}#{n}https://github.com/smartbank-inc/yapc2024-quiz";post_url$=$'https://twitter.com/intent/tweet?text='$+$URI.encode_www_form_component(post_text);;p
uts$"";puts$"$$###########################";puts$"$$#$$$$$$$%<your_answer>s$$$$$$#"$%${your_answer:decode('44GC44Gq44Gf44Gu5Zue562U')};puts$"$$##############
#############";puts$"";puts$"$$%<shop>s"$%${shop:decode('44CQQ1RP44Gu6Kiq5ZWP44GX44Gf44GK5bqX44CR')};puts$"$$$$-$#{shop_names.join("\n$$$$-$")}";puts$"";puts
$"$$%<balance>s$#{balance}%<yen>s"$%${balance:decode('44CQQ1RP44Gu5Y+j5bqn5q6L6auY44CR'),$yen:decode('5YaG')};puts$"";puts$"$$###########################";pu
ts$"$$#$$$$$$$%<score>s$$$$$$$$$$#"$%${score:decode('5o6h54K557WQ5p6c')};puts$"$$###########################";puts$"";puts$"$$%<rank_result>s"$%${rank_result
:};puts$"$$%<cto_comment>s"$%${cto_comment:};puts$"";puts$"$$$$%<bonus_result>s"$%${bonus_result:}$if$rank$==$'S';puts$"$$$$%<balance_result>s"$%${balance_re
sult:};puts$"$$$$%<shop_result>s"$%${shop_result:};puts$"";puts$"$$%<post_suggestion>s"$%${post_suggestion:decode('57WQ5p6c44KSWOOBq+aKleeov+OBl+OBpuOBv+OBvu
OBm+OCk+OBi++8nw==')};puts$"$$%<finger>s$%<post_url>s"$%${finger:decode('8J+RiQ=='),$post_url:};puts$"";).join.tr("$", 32.chr))