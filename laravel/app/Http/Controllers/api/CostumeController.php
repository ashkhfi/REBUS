<?php

namespace App\Http\Controllers\api;

use Illuminate\Support\Str;
use App\Models\costume;
use Illuminate\Http\Request;
use App\Http\Resources\Resources;
use App\Http\Controllers\Controller;
use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Storage;

class CostumeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $costumes = costume::get();
        // dd($costumes[0]->costum_types);
        $modifiedCostumes = $costumes->map(function ($costume) {
            return [
                'id' => $costume->id,
                'name' => $costume->name,
                'image' => $costume->image,
                'description' => $costume->description,
                'status' => $costume->status,
                'type' => $costume->type,
                'color' => $costume->color,
                'size' => $costume->size,
                'price' => $costume->price
            ];
        });
      
        return response()->json($modifiedCostumes );
    }

    public function store(Request $request)
    {
        try {
            $imageName = Str::random(32) . "." . $request->image->getClientOriginalExtension();

            // Create Post
            $costume = Costume::create([
                'name' => $request->name,
                'image' => $imageName,
                'description' => $request->description,
                'status' => $request->status,
                'type' => $request->type,
                'color' => $request->color,
                'size' => $request->size,
                'price' => $request->price,
            ]);

            // Save Image in Storage folder
            $request->file('image')->storeAs('/public/costumes', $imageName);

            // Return Json Response
            return response()->json([
                'message' => 'Costume successfully created.',
                'costume' => $costume,
            ], 200);
        } catch (\Exception $e) {
            // Return Json Response
            return response()->json([
                'message' => "Something went really wrong!"
            ], 500);
        }
    }



    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        // find mahasiswa by nim
        $costumes = costume::find($id);

        // check if mahasiswa exists
        if (!$costumes) {
            return new Resources(false, 'Data mahasiswa tidak ditemukan', null);
        }

        // return single mahasiswa as a resource
        return new Resources(true, 'Detail data mahasiswa!', $costumes);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        // find mahasiswa by nim
        $costumes = costume::find($id);
        if (!$costumes) {
            return response()->json(['message' => 'Data tidak ditemukan'], 404);
        } else {
            // update mahasiswa
            $costumes->update(
                [
                    'name' => $request->name,
                    'description' => $request->description,
                    'status' => $request->status,
                    'type' => $request->type,
                    'color' => $request->color,
                    'size' => $request->size,
                    'price' => $request->price,
                ]
            );
        }
        return new Resources(true, 'Data mahasiswa berhasil diupdate!', $costumes);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        // find mahasiswa by nim
        $costumes = costume::find($id);

        // Check if mahasiswa exists
        if (!$costumes) {
            return response()->json(['message' => 'Data tidak ditemukan'], 404);
        }
        //delete post
        $costumes->delete();

        //return response
        return new Resources(true, 'Data berhasil dihapus!', null);
    }
}
