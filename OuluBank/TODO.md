
# Oulu Bank TODO 

## Bank Account Tests 

- ~~When deposit using check or cash increase amount~~ 
- ~~When deposit using transfer then charge 2 percent fee to amount deposited~~
- ~~When depositing negative amount should throw exception~~  
- ~~When depositing amount then add to transaction history~~
- ~~When withdrawing and insufficient balance then charge 10% penalty of excess amount.~~ 

## APRService Tests 

-  Given a valid SSN When the credit score is greater than 650 Then getAPR should return APR for high credit score. 
-  Given a valid SSN When the credit score is greater less than 650 Then getAPR should return APR for low credit score. 
- Given a valid SSN when credit score does not exist then throws error saying invalidCreditScore.
- Given a valid SSN when credit score is undefined then throw error saying undefinedCreditScore  

## Mocking 

--- 

1. Test when credit score is above 650
Given a valid SSN
When the credit score is greater than 650
Then getAPR should return 3.124
2. Test when credit score is 650 or below
Given a valid SSN
When the credit score is 650 or below
Then getAPR should return 6.24
3. Test when no credit score is found
Given a valid SSN
When CreditScoreService returns nil
Then getAPR should throw CreditCardServiceError.noCreditScoreFound
4. Test with different credit scores to verify logic
Given a credit score of 651
Expect APR to be 3.124
Given a credit score of 650
Expect APR to be 6.24
Given a credit score of 600
Expect APR to be 6.24
5. Test if CreditScoreService.getCreditScore is called once
Given a valid SSN
When calling getAPR
Then getCreditScore(ssn:) should be called exactly once on the mock service


