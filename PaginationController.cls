public class PaginationController{
    public Integer size{get;set;} 
    public Integer noOfRecords{get; set;} 
    public List<SelectOption> paginationSizeOptions{get;set;}
    public List<WrapperClass> lstWrapOpportunity {get;set;}
         
    public PaginationController(){
        size=10;
        paginationSizeOptions = new List<SelectOption>();
        paginationSizeOptions.add(new SelectOption('5','5'));
        paginationSizeOptions.add(new SelectOption('10','10'));
        paginationSizeOptions.add(new SelectOption('20','20'));
        paginationSizeOptions.add(new SelectOption('50','50'));
        paginationSizeOptions.add(new SelectOption('100','100'));
    }
     
    public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {                
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                      [select id,Name,AccountId,Account.name,Amount,StageName,CloseDate,LastModifiedDate from Opportunity]));
                setCon.setPageSize(size);  
                noOfRecords = setCon.getResultSize();
            }            
            return setCon;
        }
        set;
    }
     
    //Changes the size of pagination
    public PageReference refreshPageSize() {
         setCon.setPageSize(size);
         return null;
    }
 
    // Initialize setCon and return a list of record 
     
    // public List<Opportunity> getOpportunities() {        
         // return (List<Opportunity>) setCon.getRecords();
    // }
    
    // returns a list of wrapper objects for the sObjects in the current page set       
    public List<WrapperClass> getOpportunities() {
        lstWrapOpportunity = new List<WrapperClass>();
        for(Opportunity opp: (List<Opportunity>) setCon.getRecords()){
             lstWrapOpportunity.add(new WrapperClass(opp));
        }
        //return (List<Opportunity>) setCon.getRecords();
        System.debug('lstWrapOpportunity:'+ lstWrapOpportunity);
        return lstWrapOpportunity;
    }
    
    public class WrapperClass{
        public Boolean isSelected {get;set;}
        public Opportunity opp {get;set;}
        
        public WrapperClass(Opportunity o){
             this.opp = o;
             this.isSelected = false;
        }   
        
    }
}