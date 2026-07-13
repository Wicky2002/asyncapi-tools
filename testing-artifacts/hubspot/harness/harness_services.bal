import ballerina/io;

listener Listener hubspotHarnessListener = check new ({clientSecret: "harness-secret", callbackURL: "http://localhost:8090/"}, 8090);

service CompanyService on hubspotHarnessListener {
    remote function onCompanyCreation(WebhookEvent event) returns error? {
        io:println("FIRED::CompanyService::onCompanyCreation");
    }
    remote function onCompanyDeletion(WebhookEvent event) returns error? {
        io:println("FIRED::CompanyService::onCompanyDeletion");
    }
    remote function onCompanyPropertychange(WebhookEvent event) returns error? {
        io:println("FIRED::CompanyService::onCompanyPropertychange");
    }
    remote function onCompanyAssociationchange(WebhookEvent event) returns error? {
        io:println("FIRED::CompanyService::onCompanyAssociationchange");
    }
    remote function onCompanyMerge(WebhookEvent event) returns error? {
        io:println("FIRED::CompanyService::onCompanyMerge");
    }
    remote function onCompanyRestore(WebhookEvent event) returns error? {
        io:println("FIRED::CompanyService::onCompanyRestore");
    }
}

service ContactService on hubspotHarnessListener {
    remote function onContactCreation(WebhookEvent event) returns error? {
        io:println("FIRED::ContactService::onContactCreation");
    }
    remote function onContactDeletion(WebhookEvent event) returns error? {
        io:println("FIRED::ContactService::onContactDeletion");
    }
    remote function onContactPropertychange(WebhookEvent event) returns error? {
        io:println("FIRED::ContactService::onContactPropertychange");
    }
    remote function onContactAssociationchange(WebhookEvent event) returns error? {
        io:println("FIRED::ContactService::onContactAssociationchange");
    }
    remote function onContactMerge(WebhookEvent event) returns error? {
        io:println("FIRED::ContactService::onContactMerge");
    }
    remote function onContactRestore(WebhookEvent event) returns error? {
        io:println("FIRED::ContactService::onContactRestore");
    }
    remote function onContactPrivacydeletion(WebhookEvent event) returns error? {
        io:println("FIRED::ContactService::onContactPrivacydeletion");
    }
}

service ConversationService on hubspotHarnessListener {
    remote function onConversationCreation(WebhookEvent event) returns error? {
        io:println("FIRED::ConversationService::onConversationCreation");
    }
    remote function onConversationDeletion(WebhookEvent event) returns error? {
        io:println("FIRED::ConversationService::onConversationDeletion");
    }
    remote function onConversationPropertychange(WebhookEvent event) returns error? {
        io:println("FIRED::ConversationService::onConversationPropertychange");
    }
    remote function onConversationPrivacydeletion(WebhookEvent event) returns error? {
        io:println("FIRED::ConversationService::onConversationPrivacydeletion");
    }
    remote function onConversationNewmessage(WebhookEvent event) returns error? {
        io:println("FIRED::ConversationService::onConversationNewmessage");
    }
}

service DealService on hubspotHarnessListener {
    remote function onDealCreation(WebhookEvent event) returns error? {
        io:println("FIRED::DealService::onDealCreation");
    }
    remote function onDealDeletion(WebhookEvent event) returns error? {
        io:println("FIRED::DealService::onDealDeletion");
    }
    remote function onDealPropertychange(WebhookEvent event) returns error? {
        io:println("FIRED::DealService::onDealPropertychange");
    }
    remote function onDealAssociationchange(WebhookEvent event) returns error? {
        io:println("FIRED::DealService::onDealAssociationchange");
    }
    remote function onDealMerge(WebhookEvent event) returns error? {
        io:println("FIRED::DealService::onDealMerge");
    }
    remote function onDealRestore(WebhookEvent event) returns error? {
        io:println("FIRED::DealService::onDealRestore");
    }
}

service TicketService on hubspotHarnessListener {
    remote function onTicketCreation(WebhookEvent event) returns error? {
        io:println("FIRED::TicketService::onTicketCreation");
    }
    remote function onTicketDeletion(WebhookEvent event) returns error? {
        io:println("FIRED::TicketService::onTicketDeletion");
    }
    remote function onTicketPropertychange(WebhookEvent event) returns error? {
        io:println("FIRED::TicketService::onTicketPropertychange");
    }
    remote function onTicketAssociationchange(WebhookEvent event) returns error? {
        io:println("FIRED::TicketService::onTicketAssociationchange");
    }
    remote function onTicketMerge(WebhookEvent event) returns error? {
        io:println("FIRED::TicketService::onTicketMerge");
    }
    remote function onTicketRestore(WebhookEvent event) returns error? {
        io:println("FIRED::TicketService::onTicketRestore");
    }
}

service ProductService on hubspotHarnessListener {
    remote function onProductCreation(WebhookEvent event) returns error? {
        io:println("FIRED::ProductService::onProductCreation");
    }
    remote function onProductDeletion(WebhookEvent event) returns error? {
        io:println("FIRED::ProductService::onProductDeletion");
    }
    remote function onProductPropertychange(WebhookEvent event) returns error? {
        io:println("FIRED::ProductService::onProductPropertychange");
    }
    remote function onProductMerge(WebhookEvent event) returns error? {
        io:println("FIRED::ProductService::onProductMerge");
    }
    remote function onProductRestore(WebhookEvent event) returns error? {
        io:println("FIRED::ProductService::onProductRestore");
    }
}

service LineItemService on hubspotHarnessListener {
    remote function onLineItemCreation(WebhookEvent event) returns error? {
        io:println("FIRED::LineItemService::onLineItemCreation");
    }
    remote function onLineItemDeletion(WebhookEvent event) returns error? {
        io:println("FIRED::LineItemService::onLineItemDeletion");
    }
    remote function onLineItemPropertychange(WebhookEvent event) returns error? {
        io:println("FIRED::LineItemService::onLineItemPropertychange");
    }
    remote function onLineItemAssociationchange(WebhookEvent event) returns error? {
        io:println("FIRED::LineItemService::onLineItemAssociationchange");
    }
    remote function onLineItemMerge(WebhookEvent event) returns error? {
        io:println("FIRED::LineItemService::onLineItemMerge");
    }
    remote function onLineItemRestore(WebhookEvent event) returns error? {
        io:println("FIRED::LineItemService::onLineItemRestore");
    }
}
