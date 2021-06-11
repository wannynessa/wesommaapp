enum BancoEnum {
  bradesco, itau, nubank}

class ListaBanco {
  List<BancoEnum> banco = BancoEnum.values;

  static int valueOf(BancoEnum banco) {
    switch (banco) {
      case BancoEnum.bradesco:
        return 0;
      case BancoEnum.itau:
        return 1;
      case BancoEnum.nubank:
        return 2;
    }
    return 0;
  }
}

