package ng.net.cyberpay.cyberpay_flutterplugin;

import com.cyberspace.cyberpaysdk.model.Split;

import java.util.List;

public class TransactionModel {

    String description = "Cyberpay Transaction";
    double amount = 0.0;
    String customerEmail = "";
    String customerName = "";
    String phoneNumber = "";
    List<Split> splits = null;
    String integrationKey;
    Boolean LiveMode;
    String amountToPay ;

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public List<Split> getSplits() {
        return splits;
    }

    public void setSplits(List<Split> splits) {
        this.splits = splits;
    }

    public String getIntegrationKey() {
        return integrationKey;
    }

    public void setIntegrationKey(String integrationKey) {
        this.integrationKey = integrationKey;
    }

    public Boolean getLiveMode() {
        return LiveMode;
    }

    public void setLiveMode(Boolean liveMode) {
        LiveMode = liveMode;
    }

    public String getAmountToPay() {
        return amountToPay;
    }

    public void setAmountToPay(String amountToPay) {
        this.amountToPay = amountToPay;
    }
}
