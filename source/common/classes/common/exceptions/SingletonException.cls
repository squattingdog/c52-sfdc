public class SingletonException extends Exception {
    private Type theType;
    public SingletonException(Type t) {
    	this.theType = t;
    }
    
    /*
    * Ouput: 
    * 	String - custom error message for mktg_SingletonException
    * Description:
    * 	This method overrides the default getMessage() method in Exception
    */
    override
    public string getMessage(){
        return this.theType.toString() + ' :: Singleton pattern exception.  Instances of a singleton class ' +
            'must be accessed through the static getInstance() method';
    }
        
}