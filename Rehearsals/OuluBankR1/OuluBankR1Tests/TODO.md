
# Oulu Bank TODO 

## Bank Account Tests for Deposit and Withdraw (Unit Tests)

- When deposit using check or cash then bank balance increases.  
- When deposit using transfer then charge fee to amount deposited.  
- Depositing negative amount is not allowed. 
- Withdrawing with insufficient balance results in penalty. 
- Deposited amount is added to the transaction history. 

## APRService Tests 

- APR is calculated within expected range for valid SSN.
- APR calculation fails for ssn with no credit score.  

## Mocking

- APR service should call get credit score on credit score service
- APR service does not call get credit score for invalid ssn   

## UITests 

- User can calculate APR successfully for valid SSN. 
- Displays error message when credit score was invalid or not found. 
