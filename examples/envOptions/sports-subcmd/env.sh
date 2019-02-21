
export SPORTS_LOCATION=outside
export SPORTS_GOAL=health
export SPORTS_TYPE=solo
export SPORTS_COST=cheap

function declareAnswer() {
    local pick=
    echo "A good $SPORTS_TYPE sport for $SPORTS_GOAL is $1."
    echo "It's usually played $SPORTS_LOCATION"
    echo "The cost to get started is $SPORTS_COST"
}

export -f declareAnswer
