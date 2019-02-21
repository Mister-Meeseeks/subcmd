
export SPORTS_GOAL=health
export SPORTS_TYPE=solo
export SPORTS_PICK=tennis

function declareAnswer() {
    echo "A good $SPORTS_TYPE sport for $SPORTS_GOAL is $SPORTS_PICK"
}

export -f declareAnswer
