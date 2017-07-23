/**
 * See https://github.com/financialforcedev/fflib-apex-common for more info
 *
 * Install library via 
 *   https://githubsfdeploy.herokuapp.com/app/githubdeploy/financialforcedev/fflib-apex-common
 */

/**
 * Base class for Domain specific builders implementing the Test Data Builder pattern as described 
 * by Nate Pryce (http://www.natpryce.com/) and Object Mother Pattern (http://www.c2.com/cgi/wiki?ObjectMother)
 *
 * For more guidelines and details see
 *   https://github.com/financialforcedev/fflib-apex-common
 *   https://github.com/financialforcedev/fflib-apex-common-samplecode
 **/
public abstract class {{ api_name }} extends fflib_DomainObjectBuilder 
{
	/**
	 * @description Constructs the Builder class with the specified SObjectType
	 *
	 * @param type The SObject type that the builder will build
	 **/
	protected {{ api_name }}(SObjectType type)
	{
		super(type);
	}

	/**
	 * @description Copy Constructor that constructs the Builder class based on the builder specified
	 *
	 * @param copyFrom The builder to copy/clone this instance from
	 **/
	protected {{ api_name }}({{ api_name }} copyFrom)
	{
		super(copyFrom);
	}

	/**
	 * @description Helper method to obtain the default Unit Of Work for use with persist methods
	 **/
	protected virtual fflib_ISObjectUnitOfWork createUnitOfWork()
	{
		/**
		 * @todo If using Application class concept from the Apex Enterprise Patterns, change the below to 
		 *       return from Application.UnitOfWork.newInstance().
		 *       If not using the Application class concept, add the default SObjectTypes that should be 
		 *       passed to Unit Of work construction.  This method will be called by derived builders 
		 *       during persist() method call.
		 */

		//return Application.UnitOfWork.newInstance();
		return new fflib_SObjectUnitOfWork(new List<SObjectType> {});
	}
}
