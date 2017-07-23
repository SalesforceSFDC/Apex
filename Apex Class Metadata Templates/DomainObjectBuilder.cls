/**
 * See https://github.com/financialforcedev/fflib-apex-common for more info
 *
 * Install library via 
 *   https://githubsfdeploy.herokuapp.com/app/githubdeploy/financialforcedev/fflib-apex-common
 */

/**
 * Domain specific class implementing the Test Data Builder pattern as described by Nate Pryce
 * (http://www.natpryce.com/) and Object Mother Pattern (http://www.c2.com/cgi/wiki?ObjectMother)
 *
 * For more guidelines and details see
 *   https://github.com/financialforcedev/fflib-apex-common
 *   https://github.com/financialforcedev/fflib-apex-common-samplecode
 **/
public class {{ api_name }} extends {{ base_name }} 
{
    /**
     * @description Default constructor
     **/
	private {{ api_name }}() 
	{
		super({{ object_name }}.SObjectType);
	}

    /**
     * @description Copy Constructor that constructs the Builder class based on the builder specified
     *
     * @param copyFrom The builder to copy/clone this instance from
     **/
	private {{ api_name }}({{ api_name }} copyFrom) 
	{
		super(copyFrom);
	}

    /**
     * @description Creates an existing SObject without issuing DML
     *              
     * @remarks Wrapper method to base class to allow for casting of specific SObjectType
	 **/
    public {{ object_name }} build() 
    {
    	return ({{ object_name }})build(false);
    }

    /**
     * @description Creates an New SObject (No Id) without issuing DML
     *              
     * @remarks Wrapper method to base class to allow for casting of specific SObjectType
	 **/
    public {{ object_name }} buildNew() 
    {
    	return ({{ object_name }})build(true);
    }

    /**
     * @description Persists builder and its related data through Unit Of Work
     *              
     * @remarks Wrapper method to base class to allow for casting of specific SObjectType
	 **/
    public {{ object_name }} persist(fflib_ISObjectUnitOfWork uow) 
    {
    	return ({{ object_name }})persistBuilder(uow);
    }

    /**
     * @description Persists builder and its related data using default unit of work
     *              
     * @remarks Wrapper method to base class to allow for casting of specific SObjectType
     **/
    public {{ object_name }} persist() 
    {
        return persist(createUnitOfWork());
    }    

    /**
     * @description Registers instance for persistance via persistBuilders
     *              
     * @remarks Wrapper method to base class to allow for casting of specific SObjectType
	 **/
    public {{ api_name }} register() 
    {
    	return ({{ api_name }})registerBuilder();
    }		

    /**
     * @description Returns Contact SObject associated to this builder
     *              
     * @remarks Wrapper method to base class to allow for casting of specific SObjectType
	 **/
    public {{ object_name }} Record 
    {
    	get { return ({{ object_name }})getRecord(); }
    	private set;
    }	    

    /**
     * @description Returns a Clone of this instance
	 **/
	public {{ api_name }} but() 
	{
		return new {{ api_name }}(this);
	}

    /**
     * @description Object Mother method for an empty {{ api_name }} instance
	 **/
	public static {{ api_name }} {{ mother_name }}() 
	{
		return new {{ api_name }}();
	}

	/*
	 * @todo Add additional Object Mother methods for commonly used values
	 *
	 * For more examples see https://github.com/financialforcedev/fflib-apex-common-samplecode
	 * 
	 *
	public static {{ api_name }} {{ mother_name }}WithRequiredFields() 
	{
		return {{ mother_name }}()
					.withName('Test Name')
					.withType('My Type');
	}
	 */

	/*
	 * @todo Add methods to set field values
	 *
	 * For more examples see https://github.com/financialforcedev/fflib-apex-common-samplecode	 
	 *
	public {{ api_name }} withName(String value) 
	{
		set({{ object_name }}.Name, value);
		return this;
	}

	public {{ api_name }} withAccount(Account_t value) 
	{
		setParent({{ object_name }}.AccountId, value);
		return this;	
	}
    */
}
