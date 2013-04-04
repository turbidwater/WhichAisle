////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.service
{
	import com.realeyes.whichAisle.control.commands.IResponder;
	import com.realeyes.whichAisle.model.vos.requests.GetItemsRequest;
	import com.realeyes.whichAisle.service.ServiceManager;
	
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.net.Responder;
	
	import org.osflash.signals.Signal;

	public class ServiceManager
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var dbInitializedSignal:Signal;
		
		private static var _instance:ServiceManager;
		
		private var _connection:SQLConnection;
		private var _dbInitialized:Boolean;
		private var _dbExists:Boolean;
		
		private var _creationSQL:Vector.<SQLStatement>;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function ServiceManager( singletonSentry:SingletonSentry )
		{
			_initialize();
		}
		
		public static function getInstance():ServiceManager
		{
			if( !_instance )
			{
				_instance = new ServiceManager( new SingletonSentry() );
			}
			
			return _instance;
		}
		
		private function _initialize():void
		{
			dbInitializedSignal = new Signal();
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath( 'database.db' );
			_dbExists = dbFile.exists;
			
			_connection = new SQLConnection();
			
			
			_connection.addEventListener( SQLEvent.OPEN, _onOpen );
			if( !_dbExists )
			{
				_connection.openAsync( dbFile, SQLMode.CREATE );
			}
			else
			{
				_connection.openAsync( dbFile, SQLMode.UPDATE );
			}
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		//=== Service Methods ===
		public function getItems( responder:IResponder, request:GetItemsRequest ):void
		{
			_checkInit();
			
			var sql:String = 'SELECT * FROM Items I, Stores S, Aisles A WHERE I.storesID = S.storesID AND I.aislesID = A.aislesID';
			if( request.storeID > 0 )
			{
				sql += ' AND storesID = ' + request.storeID;
			}
			
			if( request.staple )
			{
				sql += ' AND staple = 1';
			}
			
			_executeSQLWithResponder( sql, responder );
		}
		
		
		//=== Helper and initialization methods ===
		private function _checkInit():void
		{
			if( !_dbInitialized ) throw( new Error( "ServiceManager must be initialized first. DB hasn't initialized" ) );
		}
		
		private function _createDatabase():void
		{
			var createStores:SQLStatement = _createSQLStatement( "CREATE TABLE IF NOT EXISTS Stores (storesID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, color TEXT )" );
			var createAisles:SQLStatement = _createSQLStatement( "CREATE TABLE IF NOT EXISTS Aisles (aislesID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, storesID INTEGER)" );
			var createItems:SQLStatement = _createSQLStatement( "CREATE TABLE IF NOT EXISTS Items (itemsID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, storesID INTEGER, aislesID INTEGER, notes LONGTEXT, crossedOut INTEGER, staple INTEGER )" );
			
			_creationSQL = new <SQLStatement>[ createStores, createAisles, createItems ];
			_runCreationSQL();
		}
		
		private function _runCreationSQL():void
		{
			var sql:SQLStatement = _creationSQL.shift();
			sql.execute( -1, new Responder( _onDBCreationResult, _onDBCreationFault ) );
		}
		
		private function _executeSQLWithResponder( sql:String, responder:IResponder ):void
		{
			var sqlStatement:SQLStatement = _createSQLStatement( sql );
			sqlStatement.execute( -1, new Responder( responder.result, responder.fault ) );
		}
		
		private function _createSQLStatement( query:String ):SQLStatement
		{
			var sql:SQLStatement = new SQLStatement();
			sql.sqlConnection = _connection;
			sql.text = query;
			
			return sql;
		}
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onOpen( event:SQLEvent ):void
		{
			if( _dbExists )
			{
				_onDBCreationResult( null );
			}
			else
			{
				_createDatabase();
			}
		}
		
		private function _onDBCreationResult( event:SQLResult ):void
		{
			if( _creationSQL && _creationSQL.length > 0 )
			{
				_runCreationSQL();
			}
			else
			{
				_dbInitialized = true;
				_dbExists = true;
				
				dbInitializedSignal.dispatch( _dbInitialized );
			}
		}
		
		private function _onDBCreationFault( event:SQLError ):void
		{
			throw( new Error( "Couldn't create database" ) );
		}

		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
		public function get dbInitialized():Boolean
		{
			return _dbInitialized;
		}
	}
}

class SingletonSentry{}