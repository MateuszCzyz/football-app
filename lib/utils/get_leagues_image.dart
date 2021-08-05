String getLeaguesImage({String leagueLabel}) {
  switch (leagueLabel) {
    case 'ALL LEAGUES':
      return 'assets/images/world.svg';
    case 'SPAIN':
      return 'assets/images/spain.svg';
    case 'ENGLAND':
      return 'assets/images/uk.svg';
    case 'ITALY':
      return 'assets/images/italy.svg';
    case 'GERMANY':
      return 'assets/images/germany.svg';
    case 'POLAND':
      return 'assets/images/poland.svg';
    case 'FRANCE':
      return 'assets/images/france.svg';
    case 'NETHERLANDS':
      return 'assets/images/netherlands.svg';
    case 'PORTUGAL':
      return 'assets/images/portugal.svg';
    case 'CHAMPIONS LEAGUE':
      return 'assets/images/uefa.svg';
    default:
      return null;
  }
}
