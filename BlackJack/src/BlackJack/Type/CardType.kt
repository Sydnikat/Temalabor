package BlackJack.Type

enum class CardType {
    TWO,
    THREE,
    FOUR,
    FIVE,
    SIX,
    SEVEN,
    EIGHT,
    NINE,
    TEN,
    JACK,
    QUEEN,
    KING,
    ACE;
    fun number() =
        when(ordinal){
            in JACK.ordinal..ACE.ordinal -> 11
            else -> ordinal + 2
        }
}