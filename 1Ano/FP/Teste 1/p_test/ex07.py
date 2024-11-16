# Transforma uma string dividida por hifens ou em snake case em camel case e retorna a string resultante
# Exemplo: "the_stealth_warrior" -> "TheStealthWarrior"
# Exemplo: "The-Stealth-Warrior" -> "TheStealthWarrior"
def to_camel_case(text):
    if text == "":
        return ""
    #TODO
    pass

def main():
    assert(to_camel_case("the_stealth_warrior") == "TheStealthWarrior")
    assert(to_camel_case("The-Stealth-Warrior") == "TheStealthWarrior")
    assert(to_camel_case("A-B-C") == "ABC")
    assert(to_camel_case("the-stealth-warrior") == "TheStealthWarrior")
    assert(to_camel_case("The_Stealth_Warrior") == "TheStealthWarrior")
    print("All tests passed!")

if __name__ == "__main__":
    main()