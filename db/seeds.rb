al = UsersAccount.create(email: "al@gmail.com", password: "TestifyWork123")
al.lotteries.create(name: 'al lot1', description: 'almost', adresse: 'baker street 123', tel: '234657779')


lot2 = Lottery.create(name: 'lot2', description: 'alm', adresse: 'street 123', tel: '23657779')
lot2.users_accounts.create(email: "alexandro@gmail.com", password: "Testifyork123")