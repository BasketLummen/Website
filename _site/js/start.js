$.topic("repository.initialized").subscribe(function () {
    repository.loadOrganization();
  });
  
repository.initialize(vblOrgId, partnerTeamIds);