<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Cars;
use App\Models\Audit;

class CarsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Cars::all();
    }

    public function audit()
    {
        $data = Audit::all();
        return view('audit', compact('data'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {   
        $validated = $request->validate([
            'brand' => 'required|string|max:50',
            'model' => 'required|string|max: 50',
            'color' => 'required|string|max: 50',
            'year' => 'required|integer',
            'price' => 'required|numeric',
        ]);
        $cars = Cars::create($validated);

        return response()->json($cars, 201);

    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $cars = Cars::find($id);

        if (!$cars) {
            return response()->json([
                'message'=>'Cars not found',
            ],
        404);
        }

        return response()->json($cars, 201);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $cars = Cars::find($id);

        if (!$cars) {
            return response()->json([
                'message'=>'Cars not found',
            ],
        404);
        }

        $validated = $request->validate([
            'brand' => 'required|string|max:50',
            'model' => 'required|string|max: 50',
            'color' => 'required|string|max: 50',
            'year' => 'required|integer',
            'price' => 'required|numeric',
        ]);

        $cars->update($validated);
        return response()->json($cars, 201);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $cars = Cars::find($id);
        
        if (!$cars) {
            return response()->json([
                'message'=>'Cars not found',
            ],
        404);
        }

        $cars->delete();
        
        return response()->json([
            'message' => 'Car successfully removed.'
        ]);
    }
}
