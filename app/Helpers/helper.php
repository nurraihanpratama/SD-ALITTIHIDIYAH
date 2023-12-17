<?php

use App\Models\InvoicesWhatsappStatus;
use App\Models\LogError;
use App\Models\Team;
use App\Services\UniqueIdGenerator;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Str;


function getQueryFields($columns, $feature, $state = 'true')
{
	$fields = array_filter($columns, function ($field) use ($feature, $state) {
		return $field[$feature] === $state;
	});

	$searchableFields = array_column($fields, 'field');

	return $searchableFields;
}

function getValidatedData($table, $data): array
{
	$schema = Schema::getColumnListing($table->getTable());
	return array_filter($data, function ($item) use ($schema) {
		return in_array($item, $schema);
	}, ARRAY_FILTER_USE_KEY);
}


function saveErrorLog($th, $file)
{
	DB::transaction(function () use ($th, $file) {
		LogError::create([
			'message' => $th->getMessage(),
			'filename' => $file
		]);
	});
}

function returnBackWithData($data)
{
	return session()->put('response', [
		'token' => Str::random(10),
		'data'  => $data
	]);
}

function makeArray(mixed $query, mixed $delimiter = '-'): array
{
	if (is_array($query)) return $query;
	$query = ($query == "0") ? intval($query) : $query;
	return isset($query) ? explode($delimiter, $query) : [];
}

function sumArray($array, $key)
{
	return array_reduce($array, function ($carry, $item) use ($key) {
		return $carry + (isset($item[$key]) ? $item[$key] : 0);
	}, 0);
}


function validateSearchFields(
	mixed $requestFields,
	array $allowedFields,
	mixed $delimiter = '-'
): array {
	if ($requestFields) {
		$searchFields = makeArray($requestFields, $delimiter);
		// $areEqual = empty(array_diff($searchFields, $allowedFields)) && empty(array_diff($allowedFields, $searchFields));
		return array_intersect($allowedFields, $searchFields);
	}
}

function convertNullToZero($input)
{
	return ($input === null) ? 0 : $input;
}

function softDelete(
	$model_id,
	$model,
	$remark,
	$action,
	$deleted_at = null,
	$deleted_by = null
) {
	$time    = $deleted_at ?? now();
	$user_id = $deleted_by ?? auth()->id();

	Log::info(
		"Invoice payment id (" . $model_id . ") is " . $action . ", by user (" . auth()->id() . ") at " . $time
	);

	return $model->update([
		'deleted_at'     => $time,
		'deleted_by'     => $user_id,
		'deleted_remark' => $remark,
		'deleted_action' => $action
	]);
}

function jsonReturnWithMessage($msg)
{
	return response()->json(['msg' => $msg], 422);
}

function postRequestSize($request)
{
	$postData = $request->getContent();
	$sizeInKilobytes = round(strlen($postData) / 1024, 2);

	return $sizeInKilobytes;
}

function checkTableDbExisting($array_table = [])
{
	foreach ($array_table as $table) {
		if (!Schema::hasTable($table)) {
			return ['status' => false, 'table' => $table];
		}
	}
	return ['status' => true];
}

function firstHour($date)
{
	return Carbon::createFromFormat('Y-m-d', $date)->setTime(0, 0, 0)->toDateTimeString();
}

function lastHour($date)
{
	return Carbon::createFromFormat('Y-m-d', $date)->setTime(23, 00, 00)->toDateTimeString();
}


function deleteMe($whatDB)
{
	if ($whatDB) {
		$whatDB->delete($whatDB);
	}
}
