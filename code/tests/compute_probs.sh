# PROB(F1)="( (\"b\" | \"c\") U (\"b\" & \"c\") ) "
# PROB(F2)="( X ( P>1/3 [ ( (\"b\" | \"c\") U<=2 (\"b\" & \"c\") ) ] ) )"

FORMULA=$1

if [[ -z $1 ]]; then
    FORMULA="( \"b\" U \"c\" )"
fi

echo "Computing probabilities for formula: $FORMULA"

for i in {0..7} 
do
    echo "s$i:"
    prism ../models/a24.pm -pf "P=? [ G (s=$i) => $FORMULA ]" | grep Result
done
